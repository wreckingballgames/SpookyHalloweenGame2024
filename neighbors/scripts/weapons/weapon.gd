class_name Weapon
extends Node2D

@export var stats: WeaponStatistics

# This script is used on more than one object
# Ensure these objects exist with default, unique names
@onready var sprite_2d: Sprite2D = %Sprite2D


func _ready() -> void:
	sprite_2d.texture = stats.sprite
