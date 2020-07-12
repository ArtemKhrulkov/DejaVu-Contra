using Godot;
using System;

public class BangAnimation : AnimatedSprite
{
    public override void _Ready()
    {
        
    }
    

    private void _on_Bang_animation_finished()
    {
        Stop();
        GetParent().GetParent().QueueFree();
    }
}
