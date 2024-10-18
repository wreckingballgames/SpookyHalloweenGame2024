class_name PlayerController
extends CharacterController

signal pause_requested(id: int)
signal unpause_requested(id: int)
signal weapon_slots_cycled_up
signal weapon_slots_cycled_down
signal item_slots_cycled_up
signal item_slots_cycled_down


func _unhandled_input(event: InputEvent) -> void:
	# Handle "binary" events (like button presses, events which aren't appropriate for polling)
	pass


func _process(delta: float) -> void:
	handle_movement_input()


# TODO
func handle_movement_input() -> void:
	var movement_data: Vector2 = Vector2.ZERO

	# Handle horizontal movement
	if (Input.is_action_pressed("move_left")):
		movement_data.x = -1
	elif (Input.is_action_pressed("move_right")):
		movement_data.x = 1
	# Handle vertical movement
	if (Input.is_action_pressed("move_up")):
		movement_data.y = -1
	elif (Input.is_action_pressed("move_down")):
		movement_data.y = 1

	movement_dispatched.emit(movement_data.normalized())


# TODO
func handle_attack_input() -> void:
	# Handle attack input for associated player

	attack_performed.emit()


# TODO
func handle_pause_input() -> void:
	# Handle pause input for associated player
	# If game is paused, emit unpause_requested with player ID
	# If game is unpaused, emit pause_requested with player ID
	pass


# TODO
func handle_inventory_input() -> void:
	# Handle input for cycling weapons and items and using items for associated player
	# Emit appropriate signals depending on input
	pass
