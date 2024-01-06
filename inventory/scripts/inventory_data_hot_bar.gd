extends InventoryData
class_name InventoryDataHotBar

func pick_up_slot_data(slot_data: SlotData) -> bool:
	super.pick_up_slot_data(slot_data)
	return true
