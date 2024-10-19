class_name CharacterLifeComponent
extends Node

@export var character: Character

var modified_max_hp: int:
	set(value):
		modified_max_hp = value
		EventBus.max_hp_updated.emit(character.id, value)
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


func heal(amount: int) -> void:
	current_hp += amount


func take_damage(amount: int) -> void:
	current_hp -= amount


func _on_attack_connected(id: int, attack_power: int) -> void:
	if id != character.id:
		return
	take_damage(attack_power)


# TODO
func die() -> void:
	# TODO: Figure out best way to get killer id
	#   I'm thinking store lookup tables for killer IDs
	#   And store one on each scene that can kill characters
	EventBus.character_died.emit(character.id, -1)
