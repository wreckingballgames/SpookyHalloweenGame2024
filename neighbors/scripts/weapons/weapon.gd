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
## The amount of Bullets to store in an object pool. This is calculated by
## multiplying the Bullet's lifespan by the attack rate of the weapon and
## adding a little on top.
var bullet_pool_capacity: int
## The Weapon's bullet pool.
var bullet_pool: Array[Bullet]
## Index of next bullet to draw from the pool.
var next_bullet_index: int
## The Weapon's organization Node for bullets spawned during gameplay.
var bullet_container: Node
## Whether or not the Weapon is currently equipped.
var is_equipped: bool = false


func _ready() -> void:
	EventBus.attack_performed.connect(_on_attack_performed)

	# TODO: calculate this to be lower and correct every time
	bullet_pool_capacity = stats.ammo_capacity
	bullet_container = Node.new()
	add_child(bullet_container, true)

	sprite_2d = Sprite2D.new()
	sprite_2d.texture = stats.sprite
	add_child(sprite_2d, true)

	ammo_count = stats.ammo_capacity

	spawn_bullets()


# TODO
func _on_attack_performed(id: int) -> void:
	if id != character.id or not is_equipped:
		return
	# TODO: account for infinite ammo weapons
	# TODO: Do something special to give feedback when ammo is empty
	if ammo_count <= 0:
		return
	attack()


## Create pool of Bullet objects.
func spawn_bullets() -> void:
	# TODO: Determine if all weapons in game holding a pool of
	# ammo_capacity bullets works well
	# TODO: Account for infinite ammo (0 ammo capacity)
	for _bullet in range(bullet_pool_capacity):
		var bullet: Bullet = stats.bullet_template.instantiate()
		bullet.character = character
		bullet_container.add_child.call_deferred(bullet, true)
		bullet_pool.append(bullet)


## Account for ammo and activate the next bullet in the pool.
func attack() -> void:
	# TODO: Add feedback for trying to attack with empty weapon
	# TODO: Account for infinite ammo (0 ammo capacity)
	if ammo_count <= 0:
		return
	# TODO: Use attack rate to limit bullet spawns
	ammo_count -= 1
	get_next_bullet().activate()


## Return next Bullet in the object pool of Bullets.
func get_next_bullet() -> Bullet:
	next_bullet_index += 1
	if next_bullet_index >= bullet_pool.size():
		next_bullet_index = 0
	return bullet_pool[next_bullet_index]
