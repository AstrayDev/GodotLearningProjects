using Godot;

public partial class Gobot : CharacterBody3D
{
    [Export]
    public float RunSpeed { get; set; } = 4.0f;

    [Export]
    public float JumpVelocity { get; set; } = 5.0f;

    [Export]
    public float FallVelocity { get; set; } = 16.0f;

    [Export]
    public float WallSlideSpeed { get; set; } = 0.3f;

    private bool canDoubleJump = true;
    private Marker3D pivot;
    private AnimationPlayer anim;
    private Node3D camera;
    private RayCast3D ray;

    public override void _Ready()
    {
        pivot = GetNode<Marker3D>("Pivot");
        anim = GetNode<AnimationPlayer>("Pivot/GobotSkin/gobot/AnimationPlayer");
        camera = GetNode<Node3D>("CameraRoot");
        ray = GetNode<RayCast3D>("Pivot/RayCast");
    }

    // <--------------------------Movement Logic-------------------/>

    public override void _PhysicsProcess(double delta)
    {
        var velocity = Velocity;
        // Assigns input to vector values to then be change the transform
        var inputDir = Input.GetVector("move_right", "move_left", "move_down", "move_up");
        var direction = (camera.Transform * new Vector3(inputDir.X, 0, inputDir.Y)).Normalized();

        // If input is detected change to velocity to match input direction
        if (direction != Vector3.Zero)
        {
            velocity.X = direction.X * RunSpeed;
            velocity.Z = direction.Z * RunSpeed;

            // Chnges the player model rotation based on direction
            pivot.LookAt(Position - new Vector3(direction.X, 0, direction.Z), Vector3.Up);

            anim.Play("Run");
        }
        else
        {
            // Stops the player from moving upon release
            velocity.X = Mathf.MoveToward(Velocity.X, 0, RunSpeed);
            velocity.Z = Mathf.MoveToward(Velocity.Z, 0, RunSpeed);

            anim.Play("Idle");
        }

        // <--------------------------Jump Logic-------------------/>

        if (!IsOnFloor())
        {
            velocity.Y -= FallVelocity * (float)delta;

            anim.Play("Fall");
        }

        // Checks for jump input and allows for a single air jump if the player falls of an edge
        if (IsOnFloor())
        {
            canDoubleJump = true;

            if (Input.IsActionJustPressed("jump"))
                velocity.Y = JumpVelocity;
        }

        // Checks for double jump input if allowed
        if (!IsOnFloor() && canDoubleJump && Input.IsActionJustPressed("jump"))
        {
            velocity.Y = JumpVelocity;
            canDoubleJump = false;
        }

        // <--------------------------Wall slide and Wall Jump Logic-------------------/>

        // Wall slide
        if (ray.IsColliding() && !IsOnFloor())
        {
            velocity.Y = -WallSlideSpeed;

            canDoubleJump = true;

            anim.Play("WallSlide");
        }

        // Move the player
        Velocity = velocity;
        MoveAndSlide();

    }
}