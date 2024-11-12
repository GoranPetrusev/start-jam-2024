extends CharacterBody2D


const SPEED := 300.0
const JUMP_VELOCITY := -500.0
const MAX_FALLING_SPEED := 900.0
const FALLING_MULTIPLIER := 2.25


func _physics_process(delta: float) -> void:

	if not is_on_floor():
		fall(delta)
		
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY
		
	if Input.is_action_just_released("jump") and velocity.y < -100.0:
		velocity.y = -100.0

	process_movement()

	move_and_slide()
	

func fall(delta:float) -> void:
	if(velocity.y > 0.0):
		velocity += get_gravity() * FALLING_MULTIPLIER * delta
	else:
		velocity += get_gravity() * delta

func process_movement() -> void:
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
