class_name CharacterLifeComponent
extends Node

@export var character: Character

var modified_max_hp: int
var current_hp: int:
	set(value):
		current_hp = value
		if current_hp <= 0:
			die()


func _ready() -> void:
	modified_max_hp = character.stats.base_max_hp
	current_hp = modified_max_hp


func heal(amount: int) -> void:
	current_hp += amount


func take_damage(amount: int) -> void:
	current_hp -= amount


# TODO
func die() -> void:
	pass
