extends Node

onready var viewport1 = $VBoxContainer/ViewportContainer1/Viewport1
onready var viewport2 = $VBoxContainer/ViewportContainer2/Viewport2
onready var camera1 = $VBoxContainer/ViewportContainer1/Viewport1/Camera2D
onready var camera2 = $VBoxContainer/ViewportContainer2/Viewport2/Camera2D
onready var player1 = $VBoxContainer/ViewportContainer1/Viewport1/World/Player;
onready var player2 = $VBoxContainer/ViewportContainer2/Viewport2/World/Player;

func _ready():
	camera1.target = player1;
	camera2.target =  player2;

	 # Replace with function body.
