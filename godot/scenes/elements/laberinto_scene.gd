extends Node3D

signal next_level
signal obsidian_get

@onready var luz_mala: LuzMala = $LuzMala

func _ready() -> void:
	luz_mala.set_player($Player)

func _on_level_transition_body_entered(body: Node3D) -> void:
	if(body.get_name() == 'Player'):
		emit_signal('next_level')

func _on_interactable_obsidian_interaction() -> void:
	emit_signal('obsidian_get')
	$InteractableObsidian.hide()
	$InteractableObsidian.set_monitoring(false)
	$InteractableObsidian.set_monitorable(false)
