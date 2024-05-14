using Godot;

public partial class Camera : Node3D
{
	private float camRotV = 0.0f;
	private float camRotH = 0.0f;
	private float minCamRot = -55.0f;
	private float maxCamRot = 45.0f;

	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseMotion mouseMotion)
		{
			camRotV += mouseMotion.Relative.Y;
			camRotH += -mouseMotion.Relative.X;
		}
	}

	private Camera3D camera;
	public override void _Ready()
	{
		camera = GetNode<Camera3D>("Camera");
	}

	public override void _Process(double delta)
	{
		if (Input.IsKeyPressed(Key.Key1))
			Input.MouseMode = Input.MouseModeEnum.Captured;

		if (Input.IsKeyPressed(Key.Key2))
			Input.MouseMode = Input.MouseModeEnum.Visible;

		camRotV = Mathf.Clamp(camRotV, minCamRot, maxCamRot);

		RotationDegrees = new Vector3(camRotV, camRotH, 0);

	}
}