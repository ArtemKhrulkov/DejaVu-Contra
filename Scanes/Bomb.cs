using Godot;
using System;
using System.Collections.Generic;

public class Bomb : RigidBody2D
{
	[Signal]
	public delegate void Hit();

	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
	}

//  // Called every frame. 'delta' is the elapsed time since the previous frame.
//  public override void _Process(float delta)
//  {
//      
//  }
	private void _on_RigidBody2D_body_entered(object body)
	{
		GD.Print("TEST1");

		// Replace with function body.
	}

	private static IList<Vector2> contactPoses = new List<Vector2>();
	private static IList<Vector2> worldPoses = new List<Vector2>();


	public override void _IntegrateForces(Physics2DDirectBodyState state)
	{
		var tileMap = (TileMap) GetParent().GetNode("TileMap");
		contactPoses.Clear();
		worldPoses.Clear();
		
		for (int i = 0; i < state.GetContactCount(); i++)
		{
			var contactPos = state.GetContactLocalPosition(i);
			contactPoses.Add(contactPos);
			var worldPos = tileMap.WorldToMap(contactPos);
			if (tileMap.GetCellv(worldPos) != TileMap.InvalidCell)
			{
				worldPoses.Add(worldPos);
			}
		}
		
		Update();
	}

	public override void _Draw()
	{
		var tileMap = (TileMap) GetParent().GetNode("TileMap");

		foreach (var contactPos in contactPoses)
		{
			GD.Print("Draw contactPos");

			DrawCircle(contactPos, 100, Color.Color8(100, 0, 0));
		}

		foreach (var tilePos in worldPoses)
		{
			GD.Print("Draw worldPoses");

			DrawRect(new Rect2(tilePos * tileMap.CellSize, tileMap.CellSize), Color.Color8(100, 0, 0, 1));
		}

		base._Draw();
	}
}
