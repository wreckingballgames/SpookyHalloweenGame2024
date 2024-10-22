class_name SurvivorPickup
extends Pickup
## Class for all SurvivorPickup scenes, objects which represent survivors
## which players can collide with to rescue in the world.

## The SurvivorStatistics for the Survivor.
@export var survivor_stats: SurvivorStatistics


func _ready() -> void:
	super()

	sprite_2d.texture = survivor_stats.sprite
	# Mask both players and enemies.
	collision_mask = Constants.PLAYERS_COLLISION_LAYER | Constants.ENEMIES_COLLISION_LAYER


func _on_body_entered(body: Node2D) -> void:
	if not body is Character:
		return
	if body is PlayerCharacter:
		EventBus.survivor_rescued.emit(body.id, survivor_stats.score_value)
	else:
		EventBus.survivor_killed.emit(body.id)
	expire()
