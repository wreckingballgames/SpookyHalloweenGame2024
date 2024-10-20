class_name Pickup
extends Area2D
## This class is used for all pickup scenes, the objects which PlayerCharacters collide with to collect items.
##
## Please ensure all Pickup scenes are synchronized. They should all have
## a hitbox (a green (00ff006b) collision shape is preferred for debugging).

## The item this pickup represents.
@export var item: Item
## The amount of items picked up.
@export var amount: int

## In-game graphical representation. Set using the item's sprite property.
var sprite_2d: Sprite2D


func _ready() -> void:
	body_entered.connect(_on_body_entered)

	sprite_2d = Sprite2D.new()
	sprite_2d.texture = item.sprite
	add_child(sprite_2d, true)

	# Set to pickups collision layer and to mask players collision layer
	collision_layer = Constants.PICKUPS_COLLISION_LAYER
	collision_mask = Constants.PLAYERS_COLLISION_LAYER


## Abstract "death" code for Pickups.
func expire() -> void:
	queue_free()


func _on_body_entered(body: Node2D) -> void:
	if not body is Character:
		return
	# TODO: decide how to block players with full inventory from picking up
	EventBus.item_picked_up.emit(body.id, item.type, amount)
	expire()
