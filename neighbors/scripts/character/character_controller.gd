class_name CharacterController
extends Node

signal id_set(id: int)
signal movement_dispatched(movement_data: Vector2)
signal attack_performed
signal item_used

@export var character: Character

var id: int:
	set(value):
		id = value
		character.id = value
		id_set.emit(value)


func _ready() -> void:
	# TODO: Collaborate with multiplayer object to generate a unique id for this player
	id = 2
