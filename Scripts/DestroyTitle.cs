using Godot;

public class DestroyTitle : RigidBody2D
{
	[Signal]
	public delegate void Hit();
	
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		GD.Print("_Ready");

	}

	

	//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }


	private void _on_RigidBody2D_body_entered(object body)
	{
		GD.Print("TEST");
		// Replace with function body.
	}
}

