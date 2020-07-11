using Godot;
using System;

public class Gun : Sprite
{
	[Export]
	public int CoolDown { get; set; } = 1;
	
	[Export]
	public int XImpulse { get; set; } = 500;
	
	[Export]
	public int YImpulse { get; set; } = 100;
	
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

	public override void _Process(float delta)
	{
		DoShot();
	}

	private PackedScene _bulletScene = (PackedScene)GD.Load("res://Components/Bullet.tscn");
	
	private void DoShot()
	{
		if (LastShot == default || LastShot.AddSeconds(CoolDown) < DateTime.Now)
		{
			var bullet = _bulletScene.Instance();
			var bulletRigidBody = (RigidBody2D) bullet;
			bulletRigidBody.ApplyImpulse(new Vector2(0, 0), new Vector2(XImpulse, -YImpulse));

			AddChild(bullet);
			
			LastShot = DateTime.Now;
		}
	}

	private DateTime LastShot;
}
