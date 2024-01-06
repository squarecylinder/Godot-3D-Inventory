extends StaticBody3D

signal toggle_inventory(external_inventory_owner)

@export var inventory_data: InventoryData

func _physics_process(delta):
	look_at(PlayerManager.player.get_global_position())

func player_interact() -> void:
	toggle_inventory.emit(self)
