class_name WeaponPickup
extends Pickup
## Class for all WeaponPickup scenes, objects which represent weapons players
## can collect from the game world.

## The WeaponStatistics for the weapon to be collected.
@export var weapon_stats: WeaponStatistics


func _ready() -> void:
	super()

	sprite_2d.texture = weapon_stats.sprite


func _on_body_entered(body: Node2D) -> void:
	if not body is Character:
		return
	# TODO: decide how to block players with this weapon from picking up
	EventBus.weapon_picked_up.emit(body.id, weapon_stats)
	expire()
