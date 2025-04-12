extends CharacterBody3D


@onready var eyelids: Eyelids = $Eyelids
var eyes_are_closed: bool = false

@onready var player_camera: Camera3D = %PlayerCamera
@onready var interact_ray: RayCast3D = %InteractRay
var rayCollision = false #es true Si InteractRay del player colisiona con un área o body
@export var mouse_sensitivity = 0.01
var SPEED = 5.0
var sprinting = false


func close_eyes():
	if eyes_are_closed:
		return
	eyes_are_closed = await eyelids.close_eyes()

func open_eyes():
	if !eyes_are_closed:
		return
	eyes_are_closed = !await eyelids.open_eyes()

func check_ray_collision() -> void:
	var collider = %InteractRay.get_collider()
	#Chequea las colisiones del InteractRay del Player
	if(%InteractRay.is_colliding()):
		if(collider.get_name().contains('Interactable')):
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
		velocity.x = (camera_orientation.x * SPEED) / 2
		velocity.z = (camera_orientation.z * SPEED) / 2
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)
	
	#Sprint con SHIFT, incrementa la velocidad
	if(Input.is_action_pressed("sprint")):
		SPEED = 20.0
	else:
		SPEED = 15.0
	
	#Eyelids
	if !Input.is_action_pressed("close_eyes") and eyes_are_closed:
		open_eyes()
	
	move_and_slide()
	
	#Animación de caminar
	if (move_vector != Vector2.ZERO):
		$Head/HeadBobAnimation.play("head_bob")
	else:
		$Head/HeadBobAnimation.stop()
	
	check_ray_collision()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * mouse_sensitivity)
		player_camera.rotate_x(-event.relative.y * mouse_sensitivity)
	
	if Input.is_action_just_pressed("close_eyes"):
		close_eyes()
	
	#Sprint
	if Input.is_action_just_pressed("sprint"):
		$Head/SprintAnimation.play("camera_fov_increase")
		$Head/HeadBobAnimation.speed_scale = 1.5
	if Input.is_action_just_released("sprint"):
		$Head/SprintAnimation.play("camera_fov_decrease")
		$Head/HeadBobAnimation.speed_scale = 1.0
	
	#Tilt left
	if Input.is_action_just_pressed("move_left"):
		$Head/HeadTiltAnimation.play("tilt_left")
	if Input.is_action_just_released("move_left"):
		$Head/HeadTiltAnimation.play("untilt_left")
	
	#Tilt right
	if Input.is_action_just_pressed("move_right"):
		$Head/HeadTiltAnimation.play("tilt_right")
	if Input.is_action_just_released("move_right"):
		$Head/HeadTiltAnimation.play("untilt_right")
