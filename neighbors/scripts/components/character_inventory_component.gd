class_name CharacterInventoryComponent
extends Node
## Component for managing a Character's inventory.

## Reference to the associated Character.
@export var character: Character

var item_inventory: Dictionary
var weapon_inventory: Dictionary


func _ready() -> void:
	EventBus.item_picked_up.connect(_on_item_picked_up)
	EventBus.weapon_picked_up.connect(_on_weapon_picked_up)
	EventBus.weapon_equipped.connect(_on_weapon_equipped)
	EventBus.weapon_slots_cycled_up.connect(_on_weapon_slots_cycled_up)
	EventBus.weapon_slots_cycled_down.connect(_on_weapon_slots_cycled_down)

	# Initialize item_inventory
	# After initialization, values should only be updated; all keys should be the same
	for item_type: String in Constants.item_types:
		item_inventory[item_type] = 0
	# Ensure Character's starting weapon is in inventory and equipped
	EventBus.weapon_picked_up.emit(character.id, character.starting_weapon)
	EventBus.weapon_equipped.emit(character.id, weapon_inventory[character.starting_weapon.name])


func _on_item_picked_up(id: int, item: Item, amount: int) -> void:
	if id != character.id:
		return
	if item_inventory[Constants.item_types.keys()[item.type]] < item.capacity:
		item_inventory[Constants.item_types.keys()[item.type]] += amount


func _on_weapon_picked_up(id: int, weapon_stats: WeaponStatistics) -> void:
	if id != character.id or weapon_inventory.has(weapon_stats.name):
		return
	var new_weapon: Weapon = Weapon.new()
	new_weapon.stats = weapon_stats
	new_weapon.character = character
	new_weapon.hide()
	weapon_inventory[new_weapon.stats.name] = new_weapon
	character.add_child.call_deferred(new_weapon, true)


func _on_weapon_equipped(id: int, weapon: Weapon) -> void:
	if id != character.id:
		return
	# Don't try to re-equip the same weapon
	if character.equipped_weapon and character.equipped_weapon == weapon:
		return
	# Unequip currently equipped weapon
	if character.equipped_weapon:
		character.unequip_weapon()
	character.equip_weapon(weapon)


func _on_weapon_slots_cycled_up(id: int) -> void:
	if id != character.id:
		return
	var weapon_inventory_keys: Array = weapon_inventory.keys()
	print(weapon_inventory_keys)
	# If only one weapon is owned, do nothing
	if weapon_inventory_keys.size() == 1:
		return
	var next_weapon_index: int = weapon_inventory_keys.find(character.equipped_weapon.stats.name) + 1
	if next_weapon_index >= weapon_inventory_keys.size():
		next_weapon_index = 0
	print(next_weapon_index)
	print(weapon_inventory.get(weapon_inventory_keys[next_weapon_index]))
	character.unequip_weapon()
	character.equip_weapon(weapon_inventory.get(weapon_inventory_keys[next_weapon_index]))


func _on_weapon_slots_cycled_down(id: int) -> void:
	if id != character.id:
		return
	var weapon_inventory_keys: Array = weapon_inventory.keys()
	print(weapon_inventory_keys)
	# If only one weapon is owned, do nothing
	if weapon_inventory_keys.size() == 1:
		return
	var previous_weapon_index: int = weapon_inventory_keys.find(character.equipped_weapon.stats.name) - 1
	if previous_weapon_index < 0:
		previous_weapon_index = weapon_inventory_keys.size() - 1
	print(previous_weapon_index)
	print(weapon_inventory.get(weapon_inventory_keys[previous_weapon_index]))
	character.unequip_weapon()
	character.equip_weapon(weapon_inventory.get(weapon_inventory_keys[previous_weapon_index]))
