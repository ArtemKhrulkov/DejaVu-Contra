extends Sprite

const blue_texture = "res://Sprites/Background/blue.png";
const dark_texture = "res://Sprites/Background/red_dark.png";

func _ready():
	if get_parent().get_parent().ID == 1:
		texture = load(blue_texture)
	elif get_parent().get_parent().ID == 2:
		texture = load(dark_texture)
	else:
		texture = null;
	pass
