using Godot;
using System;

public class Gun : Sprite
{
    [Export]
    public int CoolDown { get; set; } = 200; // ms
    
    [Export]
    public int XImpulse { get; set; } = 500;
    
    [Export]
    public int YImpulse { get; set; } = 100;

    [Export]
    public int Radius { get; set; } = 10;
    
    public override void _Ready()
    {
    }

    public override void _Process(float delta)
    {

    }

    private PackedScene _bulletScene = (PackedScene)GD.Load("res://Components/Bullet.tscn");
    
    public void DoShot(bool isForward)
    {		
        var playerSize = 50;

        if (LastShot == default || LastShot.AddMilliseconds(CoolDown) < DateTime.Now)
        {
            var bullet = _bulletScene.Instance();
            ((Bomb) bullet).Radius = Radius;
            
            var bulletRigidBody = (RigidBody2D) bullet;
            var directOfXImpulse = isForward ? -1 : 1;
            bulletRigidBody.Position = new Vector2(playerSize * directOfXImpulse, 0);
            bulletRigidBody.ApplyImpulse(new Vector2(0, 0), new Vector2(XImpulse * directOfXImpulse, -YImpulse));

            AddChild(bullet);
            
            LastShot = DateTime.Now;
        }
    }

    private DateTime LastShot;
}
