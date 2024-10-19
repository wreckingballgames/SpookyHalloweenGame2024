class_name CharacterHitDetectorComponent
extends Area2D

@export var character: Character


func _ready() -> void:
	area_entered.connect(_on_area_entered)
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


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		EventBus.attack_connected.emit(character.id, area.modified_attack_power)
