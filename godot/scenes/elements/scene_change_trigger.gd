class_name SceneChangeTrigger
extends Area3D

@export var target_scene: PackedScene

func _ready() -> void:
	# Connect the signal to the function
	body_entered.connect(_on_body_entered)



func _on_body_entered(body: Node3D) -> void:
	# Check if the body is the player
	if body is Player:
		# Change the scene to the new scene
		SceneTransitionManager.transition_to_scene(target_scene, false)
