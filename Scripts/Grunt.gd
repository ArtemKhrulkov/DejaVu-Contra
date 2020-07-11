extends RigidBody2D

func _ready():
	pass 

func _physics_process(_delta):
	$AnimatedSprite.flip_h = true
	$AnimatedSprite.play()
	$Gun.DoShot($AnimatedSprite.flip_h)
