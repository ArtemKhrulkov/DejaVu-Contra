extends KinematicBody2D

onready var Player = get_parent().get_node("Player")
var vel = Vector2(0, 0)

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	vel.y += 20
	$AnimatedSprite.play()
	if Player.position.x > position.x:
		$AnimatedSprite.flip_h = false
		$GruntGun.DoShot(false)
		$AnimatedSprite.play("shoot")
	elif Player.position.x < position.x:
		$AnimatedSprite.flip_h = true
		$GruntGun.DoShot(true)
		$AnimatedSprite.play("shoot")
		
	vel = move_and_slide(vel, Vector2(0, -1))
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
