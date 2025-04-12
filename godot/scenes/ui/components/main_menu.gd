extends Control

signal quit_game
signal play_game

@onready var instrucciones: CanvasLayer = $CanvasLayer

func open() -> void:
	$MenuMusic.play()
	self.show()

func close() -> void:
	$MenuMusic.stop()
	self.hide()

func _on_credits_button_pressed() -> void:
	$Credits.visible = !$Credits.visible

func _on_play_button_pressed() -> void:
	emit_signal('play_game')

func _on_quit_button_pressed() -> void:
	emit_signal('quit_game')

func _on_music_button_pressed() -> void:
	$MenuMusic.stream_paused = !$MenuMusic.stream_paused


func _on_instruction_button_pressed() -> void:
	instrucciones.show()


func _on_texture_button_pressed() -> void:
	instrucciones.hide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel") and instrucciones.visible:
		instrucciones.hide()
