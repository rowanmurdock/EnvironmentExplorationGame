extends CharacterBody2D

@onready var anim = $AnimatedSprite2D

const SPEED = 100
const ROTATION_SPEED = 2

func _physics_process(delta):
	var rotation_dir = 0
	var movement = 0
	
	# Input checks
	if Input.is_action_pressed("ui_left"):
		rotation_dir -= 1
	if Input.is_action_pressed("ui_right"):
		rotation_dir += 1
	if Input.is_action_pressed("ui_up"):
		movement += 1
	if Input.is_action_pressed("ui_down"):
		movement -= 1
	
	# Rotation
	rotation += rotation_dir * ROTATION_SPEED * delta
	
	# Movement direction
	var direction = Vector2.RIGHT.rotated(rotation)
	velocity = direction * movement * SPEED
	move_and_slide()
	
	# Animate based on movement
	if movement != 0:
		if !anim.is_playing():
			anim.play("move")
	else:
		anim.stop()
