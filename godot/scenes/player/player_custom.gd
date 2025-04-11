class_name CustomPlayer
extends Player


@onready var player_camera: Camera3D = %PlayerCamera
@onready var interact_ray: RayCast3D = %InteractRay


func _physics_process(delta: float) -> void:
	super._physics_process(delta)
