class_name CharacterHitDetectorComponent
extends Area2D
## Component for detecting if a character has been hit by a bullet.

## Reference to the associated Character for syncing collision layers and masks.
@export var character: Character


func _ready() -> void:
	area_entered.connect(_on_area_entered)
	sync_collision_layers_with_character()
	generate_hitboxes()


## Set all of this component's collision layers and masks to character's.
func sync_collision_layers_with_character() -> void:
	collision_layer = character.collision_layer
	collision_mask = character.collision_mask


## Duplicate all of the character's hitboxes as children of this component.
func generate_hitboxes() -> void:
	for child in character.get_children():
		# Be really specific in case CollisionShape2Ds have another use later.
		if child is CollisionShape2D and child.is_in_group("hitboxes"):
			var new_hitbox := CollisionShape2D.new()
			new_hitbox.shape = child.shape
			add_child(new_hitbox, true)


func _on_area_entered(area: Area2D) -> void:
	if area is Bullet:
		EventBus.attack_connected.emit(character.id, area.character.name, area.weapon.stats.icon, area.modified_attack_power)
