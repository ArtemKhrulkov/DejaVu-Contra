extends KinematicBody2D

const SPEED = 400  # How fast the player will move (pixels/sec).
const UP = Vector2(0, -1);
const GRAVITY = 20
const JUMP_HEIGHT = -500

# Player 1 on the bottom !!!
export var ID = 0

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(_delta):
	velocity.y += GRAVITY

	if Input.is_action_pressed("movement_right_" + String(ID)) || Input.is_action_pressed("movement_left_" + String(ID)) && !IsPlayerOnBottom():
		#print(CanMoveToRight())
		print(CanMoveToLeft())
	
	
	
	if Input.is_action_pressed("movement_right_" + String(ID)):
		if CanMoveToRight():
			velocity.x = SPEED
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("movement_left_" + String(ID)):
		if CanMoveToLeft():
			velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
	
	if is_on_floor():
		if Input.is_action_just_pressed("movement_up_" + String(ID)):
			velocity.y = JUMP_HEIGHT
			
	velocity = move_and_slide(velocity, UP)

	if velocity.length() >= 0:
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	if velocity.x != 0 and is_on_floor():
		$AnimatedSprite.animation = "run"
	elif velocity.y < 0:
		$AnimatedSprite.animation = "jump"
	else:
		$AnimatedSprite.animation = "idle"
		
	if Input.is_action_pressed("movement_fire_" + String(ID)):
		$Gun.DoShot($AnimatedSprite.flip_h)

func CanMoveToLeft():
	if GetDistance() <= ScreenSize() && IsPlayerOnBottom():
		return false;
	return true
		
func CanMoveToRight():
	if GetDistance() <= ScreenSize() && !IsPlayerOnBottom():
		return false;
	return true

func GetDistance():
	return abs(position.x - AnotherPlayer().position.x);
	
func AnotherPlayer():
	if ID == 1:
		return get_parent().get_node("Player2");
	else:
		return get_parent().get_node("Player1");
	
func ScreenSize():
	return get_viewport_rect().size.x;
	
func IsPlayerOnBottom():
	if ID == 1:
		return true;
	return false;
