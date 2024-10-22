class_name Bullet
extends Area2D
## This class is used for all bullet scenes, the objects which weapons spawn and manipulate to deal damage.
##
## Give the bullet a CollisionShape2D hurtbox and set it to whatever shape and
## size you desire, then give it an AnimationPlayer and set it up to animate
## velocity or to employ a special pattern with its position. With this and
## tweaks of its statistics (especially lifespan) you can make many kinds of
## bullets very easily.

## The bullet's stats determine all of its unique attributes like attack power.
@export var stats: BulletStatistics
## The bullet's movement speed to calculate velocity. Some bullets use a
## special movement pattern with AnimationPlayer while some just move in
## the direction the Character that fired them is facing; this property is
## useful for both.
@export var speed: float

## The bullet holds a reference to the character who owns the weapon which fires the bullets in order to pass that information along.
var character: Character
## The bullet's modified attack power is its up-to-date damage value with any modifications from powerups or the like.
var modified_attack_power: int
## The bullet's Sprite2D is set from the sprite property in its stats.
var sprite_2d: Sprite2D
## The bullet's Timer is used to signal the bullet to expire() when its lifespan (see BulletStatistics) elapses.
var timer: Timer
## The bullet's rate of movement, if applicable. Calculated using speed
## and Character's direction. Bullets with special patterns don't use this.
var velocity := Vector2.ZERO

## The AnimationPlayer that drives the bullet's behavior over its lifetime.
## Ensure an AnimationPlayer with the default, unique name exists and that it
## has an animation called "move" that calls animate_velocity or animates a
## special pattern with the position property.
@onready var animation_player: AnimationPlayer = %AnimationPlayer


func _ready() -> void:
	# Dynamically create sprite
	sprite_2d = Sprite2D.new()
	add_child(sprite_2d, true)
	sprite_2d.texture = stats.sprite

	# Dynamically create lifespan timer
	timer = Timer.new()
	timer.autostart = false
	timer.one_shot = true
	timer.wait_time = stats.lifespan
	add_child(timer, true)

	modified_attack_power = stats.attack_power

	# Connect signals
	timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_body_entered)

	# Hide on instantiation
	deactivate()


func _process(delta: float) -> void:
	# Add velocity to position over time
	# Bullets with special patterns simply have a velocity of (0, 0).
	global_position += velocity * delta


func activate() -> void:
	# TODO: make bullet spawn location look right
	global_position = character.equipped_weapon.global_position
	show()
	timer.start()
	collision_layer = Constants.BULLETS_COLLISION_LAYER
	collision_mask = Constants.ENVIRONMENT_COLLISION_LAYER | Constants.ENEMIES_COLLISION_LAYER | Constants.PLAYERS_COLLISION_LAYER
	animation_player.play("move")


## This function is used to abstract "death" code for bullets. Because of
## the convenient use of object pooling here, bullets never really "die".
func deactivate() -> void:
	# Hide the bullet and disable its collision information.
	hide()
	velocity = Vector2.ZERO
	collision_layer = 0
	collision_mask = 0
	animation_player.stop()


## The bullet expires when its lifespan timer elapses.
func _on_timer_timeout() -> void:
	deactivate()


## If the bullet is not piercing, it expires on contact with physics bodies
## (besides the Character that owns it).
func _on_body_entered(body: Node2D) -> void:
	if body == character:
		return
	if not stats.is_piercing:
		deactivate()


## For AnimationPlayer to animate the bullet's velocity with programmatic
## calculations.
func animate_velocity() -> void:
	if not character:
		return
	# Cache global position to reset when going top-level
	var origin: Vector2 = global_position
	# When animating velocity, bullet should move independently.
	top_level = true
	global_position = origin

	velocity = speed * character.direction
