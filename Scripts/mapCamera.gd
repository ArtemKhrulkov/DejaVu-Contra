extends Camera2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

onready var beginPoint = GetLevelParameters().get_node("BeginPoint")
onready var endPoint = GetLevelParameters().get_node("EndPoint")

onready var player1 = GetBaseDirectory().get_node("ViewportContainer1/Viewport1/World/Player");
onready var player2 = GetBaseDirectory().get_node("ViewportContainer2/Viewport2/World/Player");

onready var pseudoPlayer1 = GetLevelParameters().get_node("PseudoPlayer1")
onready var pseudoPlayer2 = GetLevelParameters().get_node("PseudoPlayer2")

func GetBaseDirectory():
	return get_parent().get_parent().get_parent();
	
func GetLevelParameters():
	return get_parent().get_node("World/LevelPatamerers");

# Called when the node enters the scene tree for the first time.
func _ready():
	var distance = endPoint.position.x + beginPoint.position.x;
	position = Vector2(distance/2, position.y);
	zoom = Vector2(distance / get_parent().size.x, zoom.y);
	GetLevelParameters().visible = true;
	pass # Replace with function body.

func _process(delta):
	pseudoPlayer1.position = player1.position;
	pseudoPlayer2.position = player2.position;
	pass
