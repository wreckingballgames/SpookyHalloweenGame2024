class_name PlayerCharacter
extends CharacterBody2D

@export var stats: PlayerStatistics

# Should only be modified by PlayerController
var id: int


func _process(delta: float) -> void:
	move_and_slide()
