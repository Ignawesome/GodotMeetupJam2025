extends MeshInstance3D

@onready var hojas_mm: MultiMeshInstance3D = $HojasMM


func _ready() -> void:
	hojas_mm.global_transform = global_transform
	sorting_offset = randf()
