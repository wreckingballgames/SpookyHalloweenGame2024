class_name PlayerController
extends CharacterController
## PlayerCharacter's authoritative source of input. All player input is handled here before dispatching the appropriate signals.


func _unhandled_input(event: InputEvent) -> void:
	# Handle "binary" events (like button presses, events which aren't appropriate for polling)
	pass


func _process(_delta: float) -> void:
	handle_movement_input()
	handle_inventory_input()
	handle_attack_input()


## Handle all player input related to movement, generate movement data, and dispatch data via signal.
func handle_movement_input() -> void:
	var movement_data := Vector2.ZERO

	# Handle horizontal movement
	movement_data.x = Input.get_axis("move_left", "move_right")
	# Handle vertical movement
	movement_data.y = Input.get_axis("move_up", "move_down")

	EventBus.movement_dispatched.emit(id, movement_data.normalized())


# TODO
## Handle all player input related to attacking and dispatch signals.
func handle_attack_input() -> void:
	# Handle attack input for associated player

	# TODO: Determine how to handle automatic weapons
	#   I think I got it. Implement soon: toggle a flag in this component
	#    that determines whether or not to emit attack_performed signal, which is
	#    checked continuously
	if Input.is_action_just_pressed("attack"):
		EventBus.attack_performed.emit(id)


# TODO
## Handle all player input related to pausing and unpausing the game, then dispatch signals.
func handle_pause_input() -> void:
	# Handle pause input for associated player
	# If game is paused, emit unpause_requested with player ID
	# If game is unpaused, emit pause_requested with player ID
	pass


# TODO
## Handle all player input related to managing the player's inventory, then dispatch signals.
func handle_inventory_input() -> void:
	# Handle input for cycling weapons and items and using items for associated player
	# Emit appropriate signals depending on input
	if Input.is_action_just_pressed("cycle_weapon_up"):
		EventBus.weapon_slots_cycled_up.emit(character.id)
	elif Input.is_action_just_pressed("cycle_weapon_down"):
		EventBus.weapon_slots_cycled_down.emit(character.id)

	if Input.is_action_just_pressed("cycle_item_up"):
		EventBus.item_slots_cycled_up.emit(character.id)
	elif Input.is_action_just_pressed("cycle_item_down"):
		EventBus.item_slots_cycled_down.emit(character.id)
