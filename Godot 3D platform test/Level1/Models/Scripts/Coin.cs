using Godot;

public partial class Coin : Area3D
{
	private int score = 0;
	private float rotateSpeed = 0.05f;
	private Label ScoreCount;
	public override void _Ready()
	{
		ScoreCount = GetNode<Label>("/root/Main/HUD/Score");
	}

	private void On_Body_Entered(Node3D body)
	{
		score++;
		GD.Print(score);
		ScoreCount.Text = $"Score: {score}";

		QueueFree();
	}


	public override void _Process(double delta)
	{
		RotateY(rotateSpeed);
	}
}