class_name CharacterController
extends Node

@export var character: Character

var id: int:
	set(value):
		id = value
		character.id = value
		EventBus.id_set.emit(value)


func _ready() -> void:
	# TODO: Collaborate with multiplayer object to generate a unique id for this player
	id = 2
