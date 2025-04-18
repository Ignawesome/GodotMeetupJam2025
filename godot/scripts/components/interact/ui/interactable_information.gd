@icon("uid://bpptq21ud6qjd")
extends Control

@onready var information_label: Label = %InformationLabel

var current_interactable: Interactable3D


func _enter_tree() -> void:
	mouse_filter = MouseFilter.MOUSE_FILTER_IGNORE
	

func _ready() -> void:
	information_label.text = ""
	information_label.hide()

	GlobalGameEvents.interactable_focused.connect(on_interactable_focused)
	GlobalGameEvents.interactable_unfocused.connect(on_interactable_unfocused)
	GlobalGameEvents.interactable_canceled_interaction.connect(on_interactable_unfocused)
	GlobalGameEvents.interactable_interacted.connect(on_interactable_unfocused)


func on_interactable_focused(interactable: Interactable3D) -> void:
	current_interactable = interactable
	
	if current_interactable:
		information_label.show()
		information_label.text = tr(current_interactable.title_translation_key)
		

func on_interactable_unfocused(_interactable: Interactable3D) -> void:
	current_interactable = null
	information_label.text = ""
	information_label.hide()
