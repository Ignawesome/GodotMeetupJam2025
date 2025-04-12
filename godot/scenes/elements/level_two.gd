extends Node3D

func _on_area_3d_body_entered(body: Node3D) -> void:
	$AnimationPlayer.play('fade_to_credits')
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE

func _on_button_pressed() -> void:
	#Cerrar todo
	get_tree().quit()
