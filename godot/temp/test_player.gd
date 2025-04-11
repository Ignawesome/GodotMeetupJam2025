extends CharacterBody3D


const SPEED = 15.0
const JUMP_VELOCITY = 4.5

@onready var player_camera: Camera3D = %PlayerCamera

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var direction := (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.01)
		player_camera.rotate_x(-event.relative.y * 0.01)


#class_name TestPlayer
#extends CharacterBody3D
#
#@export var SPEED := 5.0
#@export var acceleration := 10.0
#
#@onready var head: Node3D = %Head
#@onready var player_camera: Camera3D = %PlayerCamera
#@onready var interact_ray: RayCast3D = %InteractRay
#
#
#func _ready() -> void:
	#Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
#
#
#func _process(delta: float) -> void:
	#var input_direction := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	#var actual_direction := Vector3.ZERO
	#actual_direction = Vector3(input_direction.x, 0.0, input_direction.y).normalized()
	#
	#actual_direction = actual_direction.rotated(Vector3.UP, global_rotation.y)
	#
	#if actual_direction:
		#actual_direction *= SPEED
		#velocity.x = move_toward(velocity.x, actual_direction.x, delta * acceleration)
		#velocity.y = move_toward(velocity.y, actual_direction.z, delta * acceleration)
	#
	#move_and_slide()
#
#
#func _input(event: InputEvent) -> void:
	#if event is InputEventMouseMotion:
		#rotate_y(-event.relative.x * 0.01)
		#player_camera.rotate_x(-event.relative.y * 0.01)
