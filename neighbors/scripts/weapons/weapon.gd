class_name Weapon
extends Node2D
## The object Characters use to damage other Characters (or pseudo-Characters) with bullets.

## The Weapon's unique attributes.
@export var stats: WeaponStatistics

## Reference to the Character which owns the Weapon.
var character: Character
## The Weapon's current remaining ammo. Melee weapons or weapons with infinite ammo always have an ammo_count of 0.
var ammo_count: int
## The Weapon's in-game sprite.
var sprite_2d: Sprite2D


func _ready() -> void:
	EventBus.attack_performed.connect(_on_attack_performed)

	sprite_2d = Sprite2D.new()
	sprite_2d.texture = stats.sprite
	add_child(sprite_2d, true)

	ammo_count = stats.ammo_capacity


# TODO
func _on_attack_performed(id: int) -> void:
	if id != character.id:
		return
	# TODO: Do something special to give feedback when ammo is empty
	if ammo_count <= 0:
		return
	# Spawn bullet and set it up (including passing character info and weapon info on)
	spawn_bullet()


func spawn_bullet() -> void:
	# TODO: Use attack rate to limit bullet spawns
	var bullet: Bullet = stats.bullet_template.instantiate()
	bullet.character = character
	add_child.call_deferred(bullet, true)
	ammo_count -= 1
