class_name WeaponStatistics
extends Resource

@export var name: String = "A weapon"
@export var sprite: Texture
@export var icon: Texture
@export var bullet_template: PackedScene
# ammo_capacity = 0 means infinite ammo (melee weapons have 0)
@export var ammo_capacity: int = 0
@export var attack_rate: int = 1
