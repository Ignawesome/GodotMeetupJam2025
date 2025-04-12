extends Control

const MAIN_GAME = ("res://scenes/MainGame.tscn")



func _ready() -> void:
	GlobalGameEvents.luz_reached_player.connect(on_player_reached)

func on_player_reached():
	get_parent().show()
	Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	get_tree().paused = true

func _on_reintentar_button_pressed() -> void:
	get_parent().hide()
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	GlobalGameEvents.request_retry.emit()
	get_tree().paused = false


func _on_menu_button_pressed() -> void:
	get_parent().hide()
	get_tree().paused = false
	get_tree().change_scene_to_file(MAIN_GAME)
