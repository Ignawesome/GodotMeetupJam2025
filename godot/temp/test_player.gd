class_name TestPlayer
extends CharacterBody3D

@export var SPEED := 5.0

@onready var head: Node3D = %Head
@onready var player_camera: Camera3D = %PlayerCamera
@onready var interact_ray: RayCast3D = %InteractRay


func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED


func _process(delta: float) -> void:
	var move_vector := Input.get_vector("move_left", "move_right", "move_forward", "move_backward")
	var camera_orientation := player_camera.basis
	
	velocity = Vector3(move_vector.x, 0.0, move_vector.y) * SPEED * delta
	
	move_and_slide()


func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		rotate_y(-event.relative.x * 0.01)
		player_camera.rotate_x(-event.relative.y * 0.01)
