extends Node

const PickUp = preload("res://item/pick_up/pick_up.tscn")

@onready var player: CharacterBody3D = $Player
@onready var inventory_interface: Control = $UI/InventoryInterface
@onready var hot_bar_inventory = $UI/HotBarInventory

func _ready():
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	inventory_interface.set_equip_inventory_data(player.equip_inventory_data)
	inventory_interface.set_hot_bar_inventory_data(player.hot_bar_inventory_data)
	hot_bar_inventory.set_inventory_data(player.hot_bar_inventory_data)
	inventory_interface.force_close.connect(toggle_inventory_interface)
	
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func toggle_inventory_interface(external_inventory_owner = null) -> void:
		inventory_interface.visible = not inventory_interface.visible
		
		if inventory_interface.visible:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else: 
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			
		if external_inventory_owner and inventory_interface.visible:
			inventory_interface.set_external_inventory(external_inventory_owner)
		else:
			inventory_interface.clear_external_inventory()


func _on_inventory_interface_drop_slot_data(slot_data) -> void:
	var pick_up = PickUp.instantiate()
	pick_up.slot_data = slot_data
	pick_up.position = player.get_drop_position()
	add_child(pick_up)
