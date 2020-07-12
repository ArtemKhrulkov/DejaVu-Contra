extends TextureButton

export var lvl1 = preload("res://Scanes/Main.tscn")

func _ready():
	pass # Replace with function body.

func _on_StartButton_button_down():
	print("Start new level")
	var _newScane = get_tree().change_scene_to(lvl1)
	pass # Replace with function body.
