extends CharacterBody3D


const SPEED = 15.0
const JUMP_VELOCITY = 4.5

@onready var player_camera: Camera3D = %PlayerCamera
@onready var interact_ray: RayCast3D = %InteractRay
var rayCollision = false #es true Si InteractRay del player colisiona con un área o body

func check_ray_collision() -> void:
	var collider = %InteractRay.get_collider()
	#Chequea las colisiones del InteractRay del Player
	if(%InteractRay.is_colliding()):
		if(collider.get_name() == 'Interactable'):
			#Si es un objeto interactuable despliega el menú de contexto
			$Context.text = 'Interactuar: (E)'
			$Context.visible = true
			#Al presionar E se interactúa con el objeto
			if(Input.is_key_pressed(KEY_E)):
				collider.enable_interaction()
	else:
		$Context.visible = false
		

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	var move_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var camera_orientation := (transform.basis * Vector3(move_vector.x, 0, move_vector.y)).normalized()
	
	if camera_orientation:
		velocity.x = camera_orientation.x * SPEED
		velocity.z = camera_orientation.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	move_and_slide()
	check_ray_collision()

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
