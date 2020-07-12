using Godot;
using System;
using System.Diagnostics;

public class TimeLabel : Label
{
	// Declare member variables here. Examples:
	// private int a = 2;
	// private string b = "text";

	// Called when the node enters the scene tree for the first time.
	public override void _Ready()
	{
		_stopwatch = new Stopwatch();

	}

	private Stopwatch _stopwatch;

	public void Start()
	{
		_stopwatch.Start();
	}
	
	public void Stop()
	{
		_stopwatch.Stop();
	}
	
	public string GetTime()
	{
		return _stopwatch.Elapsed.ToString(@"mm\:s");
	}
}
