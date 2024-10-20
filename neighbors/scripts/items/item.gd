class_name Item
extends Resource
## This Resource represents the items Characters store in their inventory and use.

## Human-readable name.
@export var name: String
## Type of item.
@export var type: Constants.item_types
## Rarity of item.
@export var rarity: Constants.item_rarities
## In-game texture.
@export var sprite: Texture
## UI texture.
@export var icon: Texture
## Strength of the item, if applicable. For example, how much damage the item deals or heals. If inapplicable, leave at 0.
@export var strength: int
## Base cooldown on item use in seconds. Continuous reuse without cooldowns is represented by 0.
@export var base_cooldown: float
## Maximum amount of this item a Character can hold. Infinite capacity is represented by 0.
@export var capacity: int
