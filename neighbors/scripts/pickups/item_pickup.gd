class_name ItemPickup
extends Pickup

## The item this pickup represents.
@export var item: Item
## The amount of items picked up.
@export var amount: int


func _ready() -> void:
	super()

	sprite_2d.texture = item.sprite


func _on_body_entered(body: Node2D) -> void:
	if not body is Character:
		return
	# TODO: decide how to block players with full inventory from picking up
	EventBus.item_picked_up.emit(body.id, item, amount)
	expire()
