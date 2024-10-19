class_name CharacterHitDetectorComponent
extends Area2D

# TODO: Implement collision code here

@export var character: Character


func _ready() -> void:
	sync_collision_layers_with_character()
	generate_hitboxes()


func sync_collision_layers_with_character() -> void:
	collision_layer = character.collision_layer
	collision_mask = character.collision_mask


func generate_hitboxes() -> void:
	for child in character.get_children():
		if child is CollisionShape2D and child.is_in_group("hitboxes"):
			var new_hitbox := CollisionShape2D.new()
			new_hitbox.shape = child.shape
			add_child(new_hitbox, true)
