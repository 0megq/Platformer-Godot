extends KinematicBody2D

var velocity: Vector2 = Vector2.ZERO
var gravity: float = 60
var max_fall: float = 600
var jump_force: float = 1000
var acc: float = 50
var max_speed: float = 300
var de_acc: float = 0.1
var air_mult: float = 0.7
var facing_right: bool = true
onready var sprite: Sprite = $Sprite
onready var sprite_scale: Vector2 = Vector2(abs(sprite.scale.x), abs(sprite.scale.y))

func _physics_process(_delta: float) -> void:
	
	var x_multiplier: float = 1
	var direction: int = 0
	
	if !is_on_floor():
		x_multiplier *= air_mult
	
	if facing_right:
		sprite.scale.x = 1 * sprite_scale.x
	else:
		sprite.scale.x = -1 * sprite_scale.x
	
	if Input.is_action_pressed("ui_right"):
		direction += 1
		facing_right = true
	if Input.is_action_pressed("ui_left"):
		direction -= 1
		facing_right = false
	
	if direction == 0:
		velocity.x = lerp(velocity.x, 0, de_acc * x_multiplier)
	#reduce acceleration/decceleration in air
	
	velocity.x += direction * acc * x_multiplier
	
	velocity.x = clamp(velocity.x, -max_speed, max_speed)
	
	if Input.is_action_pressed("ui_up") and is_on_floor():
		velocity.y = -jump_force
	
	if !is_on_floor():
		velocity.y += gravity
	if velocity.y > max_fall:
		velocity.y = max_fall
	
	move_and_slide(velocity, Vector2.UP)
