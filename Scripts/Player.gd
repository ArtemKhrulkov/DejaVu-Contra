extends KinematicBody2D

const SPEED = 400  # How fast the player will move (pixels/sec).
const UP = Vector2(0, -1);
const GRAVITY = 20
const JUMP_HEIGHT = -500

# Player 1 on the bottom !!!
export var ID = 0
var is_dead = false
export var current_id = 0

var isWinner = false;
var velocity = Vector2()
var inAbyss = false;

func dead():
	print(str(ID) + " dead")
	GetUi().Hp = GetUi().Hp - 1; 
	is_dead = true
	velocity = Vector2(0, 0)
	$AnimatedSprite.play("dead") 
	$Timer.start()
	

func _ready():
	ID = get_parent().ID
	current_id = ID;
	position = Vector2(get_parent().START_POSITION, position.y)
	pass
	
func GetUi():
	return 	GetBaseNote().get_node("CommonUi");
	
func _physics_process(_delta):
	if position.y > 250 && !is_dead:
		inAbyss = true;
		dead();
	
	if is_dead == false: 
		velocity.y += GRAVITY
		
		if Input.is_action_pressed("movement_right_" + String(current_id)):
			if CanMoveToRight():
				velocity.x = SPEED
			else:
				velocity.x = 0
			$AnimatedSprite.flip_h = false
		elif Input.is_action_pressed("movement_left_" + String(current_id)):
			if CanMoveToLeft():
				velocity.x = -SPEED
			else:
				velocity.x = 0
			$AnimatedSprite.flip_h = true
		else:
			velocity.x = 0
		
		if is_on_floor():
			if Input.is_action_just_pressed("movement_up_" + String(current_id)):
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
	if !isWinner:
		if GetDistance() <= ScreenSize() && IsPlayerOnBottom():
			return false;
		else:
			return true;
	else:
		if finishPoint().position.x - position.x >= 500:
			return false;
		else:
			return true
		
func CanMoveToRight():	
	if !isWinner:
		if GetDistance() <= ScreenSize() && !IsPlayerOnBottom() && !AnotherPlayer().isWinner:
			return false;
		else:
			return true;
	else:
		if finishPoint().position.x - position.x <= -500:
			return false;
		else:
			return true

func GetDistance():
	return abs(position.x - AnotherPlayer().position.x);

func finishPoint():
	return get_parent().get_node("Finish")

func AnotherPlayer():
	if ID == 1:
		return GetBaseNote().get_node("ViewportContainer2").get_node("Viewport2").get_node("World").get_node("Player");
	else:
		return GetBaseNote().get_node("ViewportContainer1").get_node("Viewport1").get_node("World").get_node("Player");

func GetBaseNote():
	return get_parent().get_parent().get_parent().get_parent();

func ScreenSize():
	return 3000;
	
func IsPlayerOnBottom():
	if ID == 1:
		return true;
	return false;


func _on_Timer_timeout():
	print(str(ID) + " is not dead")
	if inAbyss:
		MoveToGroung()
	$AnimatedSprite.play("alive") 
	AnotherPlayer()
	is_dead = false;
	if current_id == 1:
		current_id = 2
		AnotherPlayer().current_id = 1
	elif current_id == 2:
		current_id = 1
		AnotherPlayer().current_id = 2
	pass
	
onready var tileMap = get_parent().get_node("TileMap");
	
func MoveToGroung():
	position = Vector2(position.x + 100, -250)
