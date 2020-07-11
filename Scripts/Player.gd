extends KinematicBody2D

const SPEED = 400  # How fast the player will move (pixels/sec).
const UP = Vector2(0, -1);
const GRAVITY = 20
const JUMP_HEIGHT = -500

var velocity = Vector2()

# Called when the node enters the scene tree for the first time.
func _ready():
    pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
    velocity.y += GRAVITY
    if Input.is_action_pressed("ui_right"):
        velocity.x = SPEED
        $AnimatedSprite.flip_h = false
    elif Input.is_action_pressed("ui_left"):
        velocity.x = -SPEED
        $AnimatedSprite.flip_h = true
    else:
        velocity.x = 0
    
    if is_on_floor():
        if Input.is_action_just_pressed("ui_up"):
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
