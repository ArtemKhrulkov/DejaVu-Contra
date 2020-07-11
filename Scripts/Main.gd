extends Node

onready var viewport1 = $VBoxContainer/ViewportContainer1/Viewport1
onready var viewport2 = $VBoxContainer/ViewportContainer2/Viewport2
onready var camera1 = $VBoxContainer/ViewportContainer1/Viewport1/Camera2D
onready var camera2 = $VBoxContainer/ViewportContainer2/Viewport2/Camera2D
onready var player1 = $VBoxContainer/ViewportContainer1/Viewport1/Node2D/Player1;
onready var player2 = $VBoxContainer/ViewportContainer1/Viewport1/Node2D/Player2;


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	viewport2.world_2d = viewport1.world_2d;
	camera1.target = player1;
	camera2.target =  player2;
	 # Replace with function body.
