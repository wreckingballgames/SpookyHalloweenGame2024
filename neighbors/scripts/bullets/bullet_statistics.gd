class_name BulletStatistics
extends Resource
## This Resource determines all of a bullet's unique attributes.

## The bullet's base damage value.
@export var attack_power: int
## The bullet's in-game texture.
@export var sprite: Texture
## The bullet's UI texture.
@export var icon: Texture
## The time in seconds before the bullet expires after spawn.
@export var lifespan: float
# TODO: Imagine and add all kinds of bullet properties like the one below
## Whether or not the bullet continues moving after colliding with a physics body.
@export var is_piercing: bool
