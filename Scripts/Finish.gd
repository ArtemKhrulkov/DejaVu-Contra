extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

const minDistanceToBase = 500;

func _process(delta):
	var player = get_parent().get_node("Player")
	if abs(player.position.x - position.x) < minDistanceToBase && player.isWinner == false:
		$WinScreen.visible = true
		player.isWinner = true
		print("Win!")
	pass

