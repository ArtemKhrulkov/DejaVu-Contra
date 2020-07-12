extends KinematicBody2D

onready var Player = get_parent().get_node("Player")
var vel = Vector2(0, 0)
const GRAVITY = 20
const SPEED = 100

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _physics_process(_delta):
	$AnimatedSprite.play()
	vel.y += GRAVITY
	if Player.position.x > position.x:
		vel.x = SPEED
		$AnimatedSprite.flip_h = false
		if vel.distance_to(Player.position) > 400:
			$MovingGruntGun.DoShot(false)
		$AnimatedSprite.play("walk")
	elif Player.position.x < position.x:
		vel.x = -SPEED
		$AnimatedSprite.flip_h = true
		if vel.distance_to(Player.position) > 700:
			$MovingGruntGun.DoShot(true)
		$AnimatedSprite.play("walk")
	
	vel = move_and_slide(vel, Vector2(0, -1))

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass
