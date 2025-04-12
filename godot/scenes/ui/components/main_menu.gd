extends Control

signal quit_game
signal play_game

func _on_credits_button_pressed() -> void:
	$Credits.visible = !$Credits.visible


func _on_play_button_pressed() -> void:
	emit_signal('play_game')

func _on_quit_button_pressed() -> void:
	emit_signal('quit_game')
