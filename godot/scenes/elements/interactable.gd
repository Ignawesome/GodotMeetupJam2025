extends Node3D

@export var message = 'Texto de interacción'
var interaction_enabled = false

signal interaction

func _ready():
	$PopUp/Label.text = message + '\n(Presione X para cerrar)'

func display_message():
	$PopUp.visible = true

func hide_message():
	$PopUp.visible = false

func enable_interaction():
	interaction_enabled = true

func disable_interaction():
	interaction_enabled = false
	$CollisionShape3D.disabled = true

func handle_interaction():
	if (interaction_enabled):
		display_message()
		emit_signal('interaction')
	else:
		hide_message()
	
	if (Input.is_key_pressed(KEY_X)):
		disable_interaction()

func _process(delta):
	handle_interaction()
