class_name Bullet
extends Area2D
## This class is used for all bullet scenes, the objects which weapons spawn and manipulate to deal damage.

# TODO: implement object pooling for bullets (Android phones dood)

## The bullet's stats determine all of its unique attributes like attack power.
@export var stats: BulletStatistics
# Hurtbox is exported as bullets should only have one
## The hurtbox is the bullet's area of harm.
@export var hurtbox: CollisionShape2D

## The bullet holds a reference to the character who owns the weapon which fires the bullets in order to pass that information along.
var character: Character
## The bullet holds a reference to the weapon which fires the bullets in order to pass that information along.
var weapon: Weapon
## The bullet's modified attack power is its up-to-date damage value with any modifications from powerups or the like.
var modified_attack_power: int
## The bullet's Sprite2D is set from the sprite property in its stats.
var sprite_2d: Sprite2D
## The bullet's Timer is used to signal the bullet to expire() when its lifespan (see BulletStatistics) elapses.
var timer: Timer


func _ready() -> void:
	# Dynamically create sprite
	sprite_2d = Sprite2D.new()
	add_child(sprite_2d, true)
	sprite_2d.texture = stats.sprite

	# Dynamically create lifespan timer
	timer = Timer.new()
	add_child(timer, true)
	timer.start(stats.lifespan)
	modified_attack_power = stats.attack_power

	timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_body_entered)


## This function is used to abstract "death" code for bullets.
func expire() -> void:
	queue_free()


## The bullet expires when its lifespan timer elapses.
func _on_timer_timeout() -> void:
	expire()


## If the bullet is not piercing, it expires on contact with physics bodies.
func _on_body_entered(_body: Node2D) -> void:
	if not stats.is_piercing:
		expire()
