class_name Pickup
extends Area2D
## Base class for all pickup scenes, the objects which PlayerCharacters collide
## with to collect items or weapons. Extend before using.
##
## Please ensure all Pickup scenes are synchronized. They should all have
## a hitbox (a green (00ff006b) collision shape is preferred for debugging).

## In-game graphical representation. Set using the item/weapon's sprite property.
var sprite_2d: Sprite2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)

	sprite_2d = Sprite2D.new()
	add_child(sprite_2d, true)

	# Set to pickups collision layer and to mask players collision layer
	collision_layer = Constants.collision_layer_bits.pickups
	collision_mask = Constants.collision_layer_bits.players


## Abstract "death" code for Pickups.
func expire() -> void:
	queue_free()


func _on_body_entered(_body: Node2D) -> void:
	pass
