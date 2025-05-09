extends CharacterBody2D

@export var speed = 300
@export var rotation_speed = 3.5
@export var trail_length = 5000
@export var right_wheel_offset = Vector2(5, 6) 
@export var left_wheel_offset = Vector2(5, -7)
@export var right_bot_wheel_offset = Vector2(-8, 6) 
@export var left_bot_wheel_offset = Vector2(-8, -7)

@onready var right_trail: Line2D = $"../RightTrailLine"
@onready var left_trail: Line2D = $"../LeftTrailLine"

var rotation_direction = 0

func _ready():
	position = Vector2i(200, 200)
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
		



#func fade_trail():
	#var opacity = 1
	#while opacity>0:
		#right_trail.default_color = Color(0.423, 0.219, 0.015, opacity)
		#opacity-= 0.01
		#print(opacity)
		#await get_tree().create_timer(0.01).timeout
		#

func _physics_process(delta):
	get_input()
	rotation += rotation_direction * rotation_speed * delta
	move_and_slide()
	
	
	if velocity.length() > 0 or Input.is_action_pressed("ui_right") or Input.is_action_pressed("ui_left"):
		var right_wheel_pos = to_global(right_wheel_offset)
		var left_wheel_pos = to_global(left_wheel_offset)
		var right_bot_wheel_pos = to_global(right_bot_wheel_offset)
		var left_bot_wheel_pos = to_global(left_bot_wheel_offset)
		right_trail.add_point(right_wheel_pos)
		left_trail.add_point(left_wheel_pos)
		right_trail.add_point(right_bot_wheel_pos)
		left_trail.add_point(left_bot_wheel_pos)
		
		
		if right_trail.get_point_count() > trail_length:
			right_trail.remove_point(0)
		if left_trail.get_point_count() > trail_length:
			left_trail.remove_point(0)
		
	move_anim()
	#fade_trail()
