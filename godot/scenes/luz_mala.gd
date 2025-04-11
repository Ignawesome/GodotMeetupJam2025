class_name LuzMala
extends Area3D

@export var player : Player
@export var is_pursuing := false
@export var speed := 2.0
@export var escape_speed := 4.0

var distance_to_player := 999.

signal reached_player


func _process(delta: float) -> void:
	if is_instance_valid(player):
		var player_location = player.global_position
		player_location.y += 0.7
		distance_to_player = player_location.distance_squared_to(self.global_position)
		
		var direction_to_player = (player_location - self.global_position).normalized()

		is_pursuing = !player.eyes_are_closed

		if is_pursuing:
			global_position = global_position.move_toward(player_location, delta * speed)
		else:
			global_position = global_position.move_toward(to_global(-direction_to_player), delta * escape_speed)


func _on_body_entered(body: Node3D) -> void:
	if body is Player:
		reached_player.emit()
