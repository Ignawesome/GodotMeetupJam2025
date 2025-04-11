class_name Eyelids
extends CanvasLayer

@onready var animation_player: AnimationPlayer = %AnimationPlayer


signal eyes_closed
signal eyes_opened

func close_eyes() -> bool:
	if animation_player.is_playing():
		return false
	animation_player.play("close_eyes")
	await animation_player.animation_finished
	eyes_closed.emit()
	return true

func open_eyes() -> bool:
	if animation_player.is_playing():
		return false
	animation_player.play_backwards("close_eyes")
	await animation_player.animation_finished
	eyes_opened.emit()
	return true
