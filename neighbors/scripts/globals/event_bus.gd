extends Node

#region Character signals

# CharacterController
signal id_set(id: int)
signal movement_dispatched(movement_data: Vector2)
signal attack_performed
signal item_used

# PlayerController
signal pause_requested(id: int)
signal unpause_requested(id: int)
signal weapon_slots_cycled_up
signal weapon_slots_cycled_down
signal item_slots_cycled_up
signal item_slots_cycled_down

# Movement

# Life
signal hp_updated(new_hp: int)
signal max_hp_updated(new_max_hp: int)
signal character_died(id: int, killer_id: int)

# Hit Detector
signal attack_connected(attack_power: int)

#endregion
