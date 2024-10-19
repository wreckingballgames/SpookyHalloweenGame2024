class_name CharacterLifeComponent
extends Node
## Component for tracking and updating a character's life as well as handling character death.

## Reference to the associated character.
@export var character: Character

## Up-to-date maximum hit points.
var modified_max_hp: int:
	set(value):
		modified_max_hp = value
		EventBus.max_hp_updated.emit(character.id, value)
## Current remaining hit points.
var current_hp: int:
	set(value):
		current_hp = value
		EventBus.hp_updated.emit(character.id, current_hp)
		if current_hp <= 0:
			die()


func _ready() -> void:
	EventBus.attack_connected.connect(_on_attack_connected)

	modified_max_hp = character.stats.base_max_hp
	current_hp = modified_max_hp


## Heal the character.
func heal(amount: int) -> void:
	current_hp += amount


## Deal damage to the character.
func take_damage(amount: int) -> void:
	current_hp -= amount


func _on_attack_connected(id: int, attack_power: int) -> void:
	if id != character.id:
		return
	take_damage(attack_power)


# TODO
## Handle character death.
func die() -> void:
	# TODO: Figure out best way to get killer id
	#   I'm thinking store lookup tables for killer IDs
	#   And store one on each scene that can kill characters
	EventBus.character_died.emit(character.id, -1)
