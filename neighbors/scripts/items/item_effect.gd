class_name ItemEffect
extends Node2D
## The "physical" in-game effect associated with a given Item. Should be
## extended before use.
# TODO: decide if it should be extended before use or make a cool, simple interface that all use

## The Item this effect is associated with. Provides strength value and any other
## information needed.
@export var item: Item
