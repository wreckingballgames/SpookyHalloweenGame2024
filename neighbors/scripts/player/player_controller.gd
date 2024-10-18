class_name PlayerController
extends CharacterController


func _unhandled_input(event: InputEvent) -> void:
	# Handle "binary" events (like button presses, events which aren't appropriate for polling)
	pass


func _process(_delta: float) -> void:
	handle_movement_input()


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

	EventBus.movement_dispatched.emit(movement_data.normalized())


# TODO
func handle_attack_input() -> void:
	# Handle attack input for associated player

	# TODO: Determine how to handle automatic weapons
	#   They should be polled in _process and toggled on the weapon (is firing or not)

	EventBus.attack_performed.emit()


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
