extends CharacterBody2D

@export var speed = 90
@export var rotation_speed = 3.5
@export var trail_length = 5000
@export var right_wheel_offset = Vector2(-8, 6) 
@export var left_wheel_offset = Vector2(-8, -6)

@onready var right_trail: Line2D = $"../RightTrailLine"
@onready var left_trail: Line2D = $"../LeftTrailLine"

var rotation_direction = 0

func _ready():
	position = Vector2(200, 200)
	right_trail.z_index = 0
	z_index = 2
	


func get_input():
	rotation_direction = Input.get_axis("ui_left", "ui_right")
	velocity = transform.x * Input.get_axis("ui_down", "ui_up") * speed

func move_anim():
	if velocity.length() > 0 or Input.is_action_pressed("ui_left") or Input.is_action_pressed("ui_right"):
		$AnimatedSprite2D.play("move")
	else:
		$AnimatedSprite2D.play("default")

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	
	
	if velocity.length() > 0 or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		var right_wheel_pos = to_global(right_wheel_offset)
		var left_wheel_pos = to_global(left_wheel_offset)
		right_trail.add_point(right_wheel_pos)
		left_trail.add_point(left_wheel_pos)
		
		
		if right_trail.get_point_count() > trail_length:
			right_trail.remove_point(0)
		if left_trail.get_point_count() > trail_length:
			left_trail.remove_point(0)
		
		
	
	move_anim()
