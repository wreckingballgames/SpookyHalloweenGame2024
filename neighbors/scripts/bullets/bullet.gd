class_name Bullet
extends Area2D

# TODO: implement object pooling for bullets (Android phones dood)

@export var stats: BulletStatistics
# Hurtbox is exported as bullets should only have one
@export var hurtbox: CollisionShape2D

var character: Character
var weapon: Weapon
var modified_attack_power: int

# This script is used on more than one object
# Ensure these objects exist with default, unique names
@onready var sprite_2d: Sprite2D = %Sprite2D
@onready var timer: Timer = %Timer


func _ready() -> void:
	timer.timeout.connect(_on_timer_timeout)
	body_entered.connect(_on_body_entered)

	sprite_2d.texture = stats.sprite
	timer.wait_time = stats.lifespan
	modified_attack_power = stats.attack_power


## This function is used to abstract "death" code for bullets.
func expire() -> void:
	queue_free()


func _on_timer_timeout() -> void:
	expire()


func _on_body_entered(_body: Node2D) -> void:
	if not stats.is_piercing:
		expire()
