extends Node3D

signal finished

func _ready():
	$TextAnimation.play("fade_in")
	$CameraAnimation.play("camera_pan")

func _on_text_animation_animation_finished(anim_name: StringName) -> void:
	emit_signal('finished')
