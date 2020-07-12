using System;
using Godot;
using System.Collections.Generic;
using System.Linq;

public class Bomb : RigidBody2D
{
	[Export] public int Radius { get; set; } = 10;
	
	public override void _Ready()
	{
		var animation = GetChild<Sprite>(0).GetChild<AnimatedSprite>(0);
		animation.Scale = new Vector2(Radius / 5, Radius / 5);
	}

	public override void _IntegrateForces(Physics2DDirectBodyState state)
	{
		if (IsMaxDistance())
			RunBangAnimation();

		for (int i = 0; i < state.GetContactCount(); i++)
		{
			var contactLocalPosition = state.GetContactLocalPosition(i);
			var tilesInRadius = GetTilesInRadius(GetTileMap, contactLocalPosition, Radius);

			if (tilesInRadius.Any())
				RunBangAnimation();

			foreach (var cell in tilesInRadius)
			{
				GetTileMap.SetCell((int) cell.x, (int) cell.y, -1);
				GetAnotherTileMap(GetAnotherNumber()).SetCell((int) cell.x, (int) cell.y, -1);
			}
		}
	}

	private int GetAnotherNumber()
	{
		return GetWorldBase.GetParent().Name.Contains(1.ToString()) 
			? 2 
			: 1;
	}

	private const int MaxDistance = 1000;
	
	private bool IsMaxDistance()
	{
		return Math.Abs(Position.x) > MaxDistance;
	}
	
	private TileMap GetTileMap => (TileMap) GetWorldBase.GetNode("TileMap"); 
	private TileMap GetAnotherTileMap(int number) => (TileMap) GetCameraBase
		.GetNode($"ViewportContainer{number}").GetNode($"Viewport{number}").GetNode("World")
		.GetNode("TileMap");

	private Node GetWorldBase => GetParent().GetParent().GetParent();
	private Node GetCameraBase => GetWorldBase.GetParent().GetParent().GetParent();
	
	private void RunBangAnimation()
	{
		var animation = GetChild<Sprite>(0).GetChild<AnimatedSprite>(0);
		animation.Visible = true;
		animation.Playing = true;
	}

	private IList<Vector2> GetTilesInRadius(TileMap tileMap, Vector2 centerPoint, int radius)
	{
		if (GetTileMap == null)
		{
			return new List<Vector2>();
		}
		
		var tiles = new List<Vector2>();
		
		var startPoint = new Vector2(centerPoint.x - radius, centerPoint.y - radius);
		for (var x = 0; x < 2 * radius; x++)
		{
			for (var y = 0; y < 2 * radius; y++)
			{
				var worldPos = tileMap.WorldToMap(new Vector2(startPoint.x + x, startPoint.y + y));
				var cell = tileMap.GetCellv(worldPos);
				
				// change to hash
				if (cell != TileMap.InvalidCell && tiles.All(t => t != worldPos))
					tiles.Add(worldPos);
			}
		}

		return tiles;

	}
}
