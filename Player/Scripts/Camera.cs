using Godot;

public partial class Camera : Node3D
{
	private float camRotV = 0.0f;
	private float camRotH = 0.0f;
	private float minCamRot = -55.0f;
	private float maxCamRot = 75.0f;

	public override void _Input(InputEvent @event)
	{
		if (@event is InputEventMouseMotion mouseMotion)
		{
			camRotV += mouseMotion.Relative.Y;
			camRotH += -mouseMotion.Relative.X;
		}
	}

	private float camH;
	private float camV;
	public override void _Ready()
	{
		camH = GetNode<Node3D>("Horizontal").RotationDegrees.Y;
		camV = GetNode<Node3D>("Horizontal/Vertical").RotationDegrees.X;
	}

	public override void _Process(double delta)
	{
		camRotV = Mathf.Clamp(camRotV, minCamRot, maxCamRot);

		RotationDegrees = new Vector3(camRotV, camRotH, 0);
	}
}