extends KinematicBody2D

const GRAVITY = 20
const FLOOR = Vector2(0, -1)
onready var Player = get_parent().get_node("Player")
var vel = Vector2(0, 0)
var is_dead = false

func dead():
	is_dead = true
	vel = Vector2(0, 0)
	$AnimatedSprite.play("dead") 
	$CollisionShape2D.set_deferred("disabled", true)
	$Timer.start()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(_delta):
	vel.y += GRAVITY
	if is_dead == false:
		$AnimatedSprite.play()
		
		if Player && !Player.is_dead && abs(Player.position.x - position.x) < 2000:
			if Player.position.x > position.x:
				$GruntGun.DoShot(false)
				$AnimatedSprite.play("shoot")
			elif Player.position.x < position.x:
				$AnimatedSprite.flip_h = true
				$GruntGun.DoShot(true)
				$AnimatedSprite.play("shoot")
			
		vel = move_and_slide(vel, FLOOR)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#    pass


func _on_Timer_timeout():
	queue_free()
