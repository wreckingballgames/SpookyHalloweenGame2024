class_name CharacterInventoryComponent
extends Node
## Component for managing a Character's inventory.

## Reference to the associated Character.
@export var character: Character

## The Character's inventory of items. Has room for all possible items in the game.
var item_inventory: Dictionary
## The Character's inventory of weapons. Only holds entries for acquired weapons.
var weapon_inventory: Dictionary


func _ready() -> void:
	EventBus.item_picked_up.connect(_on_item_picked_up)
	EventBus.item_equipped.connect(_on_item_equipped)
	EventBus.item_used.connect(_on_item_used)
	EventBus.item_slots_cycled_up.connect(_on_item_slots_cycled_up)
	EventBus.item_slots_cycled_down.connect(_on_item_slots_cycled_down)

	EventBus.weapon_picked_up.connect(_on_weapon_picked_up)
	EventBus.weapon_equipped.connect(_on_weapon_equipped)
	EventBus.weapon_slots_cycled_up.connect(_on_weapon_slots_cycled_up)
	EventBus.weapon_slots_cycled_down.connect(_on_weapon_slots_cycled_down)

	# Initialize item_inventory
	# After initialization, only values should be updated; all keys should be the same
	for item_type: String in Constants.item_types:
		item_inventory[item_type] = 0
	# Add starting item to inventory and equip it
	# Be dilligent about using signals so all the game systems know what's up
	EventBus.item_picked_up.emit(character.id, character.starting_item, character.starting_item_amount)
	EventBus.item_equipped.emit(character.id, character.starting_item.type)
	# Ensure Character's starting weapon is in inventory and equipped
	# Be dilligent about using signals so game systems can track info.
	EventBus.weapon_picked_up.emit(character.id, character.starting_weapon)
	EventBus.weapon_equipped.emit(character.id, weapon_inventory[character.starting_weapon.name])


func _on_item_picked_up(id: int, item: Item, amount: int) -> void:
	if id != character.id:
		return
	# Pay close attention to how enum entries are used as strings here
	if item_inventory[Constants.item_types.keys()[item.type]] < item.capacity:
		item_inventory[Constants.item_types.keys()[item.type]] += amount


func _on_item_equipped(id: int, item_type: Constants.item_types) -> void:
	if id != character.id:
		return
	character.equip_item(item_type)


# TODO
func _on_item_used(id: int) -> void:
	if id != character.id:
		return


func _on_item_slots_cycled_up(id: int) -> void:
	if id != character.id:
		return
	# Because GDScript doesn't have string enums, this is a little complicated.
	# Get keys in item_inventory (strings)
	var item_inventory_keys: Array = item_inventory.keys()
	# Get enum value of key for current equipped item, find the location of item
	# in keys list, add 1 to get next location
	var current_item_index: int = item_inventory_keys.find(Constants.item_types.keys()[character.equipped_item])
	var next_item_index: int = current_item_index + 1
	# Don't index out of bounds
	if next_item_index >= item_inventory.size():
		next_item_index = 0
	# Only cycle through items the Character owns
	while (item_inventory[item_inventory_keys[next_item_index]] == 0) and (next_item_index != current_item_index):
		next_item_index += 1
		if next_item_index >= item_inventory.size():
			next_item_index = 0
	# Convert key (string) back into enum value to equip item
	EventBus.item_equipped.emit(character.id, Constants.item_types[item_inventory_keys[next_item_index]])


func _on_item_slots_cycled_down(id: int) -> void:
	if id != character.id:
		return
	# Because GDScript doesn't have string enums, this is a little complicated.
	# Get keys in item_inventory (strings)
	var item_inventory_keys: Array = item_inventory.keys()
	# Get enum value of key for current equipped item, find the location of item
	# in keys list, subtract 1 to get previous location
	var current_item_index: int = item_inventory_keys.find(Constants.item_types.keys()[character.equipped_item])
	var previous_item_index: int = current_item_index - 1
	# Don't index out of bounds
	if previous_item_index < 0:
		previous_item_index = item_inventory.size() - 1
	# Only cycle through items the Character owns
	while (item_inventory[item_inventory_keys[previous_item_index]] == 0) and (previous_item_index != current_item_index):
		previous_item_index -= 1
		if previous_item_index < 0:
			previous_item_index = item_inventory.size() - 1
	# Convert key (string) back into enum value to equip item
	EventBus.item_equipped.emit(character.id, Constants.item_types[item_inventory_keys[previous_item_index]])


func _on_weapon_picked_up(id: int, weapon_stats: WeaponStatistics) -> void:
	if id != character.id or weapon_inventory.has(weapon_stats.name):
		return
	var new_weapon := Weapon.new()
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
	character.unequip_weapon()
	character.equip_weapon(weapon)


func _on_weapon_slots_cycled_up(id: int) -> void:
	if id != character.id:
		return
	var weapon_inventory_keys: Array = weapon_inventory.keys()
	# If only one weapon is owned, do nothing
	if weapon_inventory_keys.size() == 1:
		return
	var next_weapon_index: int = weapon_inventory_keys.find(character.equipped_weapon.stats.name) + 1
	if next_weapon_index >= weapon_inventory_keys.size():
		next_weapon_index = 0
	EventBus.weapon_equipped.emit(character.id, weapon_inventory.get(weapon_inventory_keys[next_weapon_index]))


func _on_weapon_slots_cycled_down(id: int) -> void:
	if id != character.id:
		return
	var weapon_inventory_keys: Array = weapon_inventory.keys()
	# If only one weapon is owned, do nothing
	if weapon_inventory_keys.size() == 1:
		return
	var previous_weapon_index: int = weapon_inventory_keys.find(character.equipped_weapon.stats.name) - 1
	if previous_weapon_index < 0:
		previous_weapon_index = weapon_inventory_keys.size() - 1
	EventBus.weapon_equipped.emit(character.id, weapon_inventory.get(weapon_inventory_keys[previous_weapon_index]))
