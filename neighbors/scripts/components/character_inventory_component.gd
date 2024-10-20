class_name CharacterInventoryComponent
extends Node
## Component for managing a Character's inventory.

## Reference to the associated Character.
@export var character: Character

var item_inventory: Dictionary
var weapon_inventory: Dictionary


func _ready() -> void:
	EventBus.item_picked_up.connect(_on_item_picked_up)
	EventBus.weapon_equipped.connect(_on_weapon_equipped)

	# Initialize item_inventory
	# After initialization, values should only be updated; all keys should be the same
	for item_type: String in Constants.item_types:
		item_inventory[item_type] = 0


func _on_item_picked_up(id: int, item_type: Constants.item_types, amount: int) -> void:
	if id != character.id:
		return
	item_inventory[Constants.item_types.keys()[item_type]] += amount


func _on_weapon_equipped(id: int, weapon: Weapon) -> void:
	if id != character.id:
		return
	weapon_inventory[weapon.name] = weapon
