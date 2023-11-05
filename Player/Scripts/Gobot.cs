using Godot;

public partial class Gobot : CharacterBody3D
{
    [Export]
    public float speed { get; set; } = 8.0f;

    [Export]
    public float jumpVelocity { get; set; } = 5.0f;

    [Export]
    public float fallVelocity { get; set; } = 16.0f;

    private bool canDoubleJump = true;
    private Marker3D pivot;
    private AnimationPlayer anim;
    private Node3D camera;

    public override void _Ready()
    {
        pivot = GetNode<Marker3D>("Pivot");
        anim = GetNode<AnimationPlayer>("Pivot/GobotSkin/gobot/AnimationPlayer");
        camera = GetNode<Node3D>("CameraRoot");
    }

    public override void _PhysicsProcess(double delta)
    {
        var velocity = Velocity;
        // Assigns input to vector values to then be change the transform
        var inputDir = Input.GetVector("move_right", "move_left", "move_down", "move_up");
        var direction = (camera.Transform.Basis * new Vector3(inputDir.X, 0, inputDir.Y)).Normalized();

        // If input is detected change to velocity to match input direction
        if (direction != Vector3.Zero)
        {
            velocity.X = direction.X * speed;
            velocity.Z = direction.Z * speed;

            // Chnges the player model rotation based on direction
            pivot.LookAt(Position - direction, Vector3.Up);

            anim.Play("Run");
        }
        else
        {
            // Stops the player from moving upon release
            velocity.X = Mathf.MoveToward(Velocity.X, 0, speed);
            velocity.Z = Mathf.MoveToward(Velocity.Z, 0, speed);

            anim.Play("Idle");
        }

        if (!IsOnFloor())
        {
            velocity.Y -= fallVelocity * (float)delta;

            anim.Play("Fall");
        }

        if (IsOnFloor())
        {
            canDoubleJump = true;

            if (Input.IsActionJustPressed("jump"))
                velocity.Y = jumpVelocity;
        }


        if (!IsOnFloor() && canDoubleJump && Input.IsActionJustPressed("jump"))
        {
            velocity.Y = jumpVelocity;
            canDoubleJump = false;
        }

        // Move the player
        Velocity = velocity;
        MoveAndSlide();

    }
}