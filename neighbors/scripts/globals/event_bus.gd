extends Node

#region Character signals

# CharacterController
signal id_set(id: int)
signal movement_dispatched(id: int, movement_data: Vector2)
signal attack_performed(id: int)
signal item_used(id: int)

# PlayerController
signal pause_requested(id: int)
signal unpause_requested(id: int)
signal weapon_slots_cycled_up(id: int)
signal weapon_slots_cycled_down(id: int)
signal item_slots_cycled_up(id: int)
signal item_slots_cycled_down(id: int)

# Movement

# Life
signal hp_updated(id: int, new_hp: int)
signal max_hp_updated(id: int, new_max_hp: int)
signal character_died(id: int, killer_id: int)

# Hit Detector
signal attack_connected(id: int, attacker_name: String, weapon_icon: Texture, attack_power: int)

#endregion
