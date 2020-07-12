extends RigidBody2D

export var ItemType = 1;

# Dictionary (mutliline, since it avoids the ugly quotation marks) (thanks @sal_vager)
const ItemTypes = {
	Health = 1,
	GrenadeLauncher = 2,
	Gatling = 3
}

onready var sprite = $Sprite;

onready var HealthSprite = load("res://Sprites/items/hp_64.png")
onready var GrenadeLauncherSprite = load("res://Sprites/items/grenade_launcher_64.png")
onready var GatlingSprite = load("res://Sprites/items/gatling_gun_64.png");

func _ready():
	#
	if ItemType == ItemTypes.Health:
		$Sprite.texture = HealthSprite;
	elif ItemType == ItemTypes.GrenadeLauncher:
		$Sprite.texture = GrenadeLauncherSprite;
	elif ItemType == ItemTypes.Gatling:
		$Sprite.texture = GatlingSprite;
	else:
		queue_free();
	pass # Replace with function body.

#func _process(delta): 
#	pass

func _on_Item_body_entered(body):
	if body.get_name() == "Player" :
		get_parent().get_node("Player/Inventory").GetItem(ItemType)	;
		queue_free()
	pass # Replace with function body.
