class_name CharacterHitboxComponent
extends Node

# TODO: Implement collision code here

@export var character: Character

var hitboxes: Array[CollisionShape2D]


func _ready() -> void:
	for child in character.get_children():
		var hitbox = child as CollisionShape2D
		if hitbox:
			hitboxes.append(hitbox)
