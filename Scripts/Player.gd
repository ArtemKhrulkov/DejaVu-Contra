extends KinematicBody2D

const SPEED = 400  # How fast the player will move (pixels/sec).
const UP = Vector2(0, -1);
const GRAVITY = 20
const JUMP_HEIGHT = -500

# Player 1 on the bottom !!!
export var ID = 0

var velocity = Vector2()

func _ready():
	ID = get_parent().ID
	position = Vector2(get_parent().START_POSITION, position.y)
	pass
	
func _physics_process(_delta):
	velocity.y += GRAVITY
	
	if Input.is_action_pressed("movement_right_" + String(ID)):
		if CanMoveToRight():
			velocity.x = SPEED
		else:
			velocity.x = 0
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("movement_left_" + String(ID)):
		if CanMoveToLeft():
			velocity.x = -SPEED
		else:
			velocity.x = 0
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
		return GetBaseNote().get_node("ViewportContainer2").get_node("Viewport2").get_node("World").get_node("Player");
	else:
		return GetBaseNote().get_node("ViewportContainer1").get_node("Viewport1").get_node("World").get_node("Player");

func GetBaseNote():
	return get_parent().get_parent().get_parent().get_parent();

func ScreenSize():
	return 2000;
	
func IsPlayerOnBottom():
	if ID == 1:
		return true;
	return false;
