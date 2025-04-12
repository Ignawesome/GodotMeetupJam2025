extends CanvasLayer

signal resume_game
signal quit_game
@onready var resume_button = $MainButtons/ResumeButton
@onready var quit_pause_button = $MainButtons/QuitPauseButton
@onready var confirm_quit_menu = $ConfirmQuitMenu

func _on_cancel_quit_pressed() -> void:
	confirm_quit_menu.hide()
	resume_button.show()
	quit_pause_button.show()

func _on_confirm_quit_pressed() -> void:
	emit_signal('quit_game')

func _on_resume_button_pressed() -> void:
	emit_signal('resume_game')

func _on_quit_pause_button_pressed() -> void:
	resume_button.hide()
	quit_pause_button.hide()
	confirm_quit_menu.show()
