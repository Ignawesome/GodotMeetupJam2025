extends Node


#region Physics layers
const world_collision_layer: int = 1
const player_collision_layer: int = 2
const enemies_collision_layer: int = 4
const hitboxes_collision_layer: int = 8
const shakeables_collision_layer: int = 16
const interactables_collision_layer: int = 32
const grabbables_collision_layer: int = 64
const bullets_collision_layer: int = 128
const playing_cards_collision_layer: int = 256
const ladders_collision_layer: int = 512
#endregion

#region Progress
var obsidian_collected := false
var letter_collected := false
var horn_collected := false


#endregion

func _ready() -> void:
	GlobalGameEvents.interactable_interacted.connect(_on_interactible_interacted)


func _on_interactible_interacted(interactible: Interactable3D):
	var title_upper := interactible.title.to_upper()
	if title_upper == "OBSIDIAN":
		obsidian_collected = true
		interactible.queue_free()
		return
	elif title_upper == "LETTER":
		letter_collected = true
		interactible.queue_free()
		return
	elif title_upper == "HORN":
		horn_collected = true
		interactible.queue_free()
		return


#region General helpers
## Example with lambda -> Utilities.delay_func(func(): print("test"), 1.5)
## Example with arguments -> Utilities.delay_func(print_text.bind("test"), 2.0)
func delay_func(callable: Callable, time: float, deferred: bool = true):
	if callable.is_valid():
		await wait(time)
		
		if deferred:
			callable.call_deferred()
		else:
			callable.call()

## Example of use: await GameGlobals.wait(1.5)
func wait(seconds: float = 1.0):
	return get_tree().create_timer(seconds).timeout
	
#endregion
