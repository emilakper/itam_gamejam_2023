extends Resource

class_name Inv

signal updated_slot
signal failed_update_slot

@export var slots : Array[InvSlot]
@export var money : float = 0

func add(item : InvItem) -> bool:
	var itemslots=slots.filter(func(slot) : return slot.item==item && slot.amount<99)
	if !itemslots.is_empty():
		itemslots[0].amount+=1
		emit_signal("updated_slot")
		return 1
	else:
		var emptyslots=slots.filter(func(slot) : return slot.amount==0 or slot==null or slot.item==null)
		if !emptyslots.is_empty():
			emptyslots[0].amount=1
			emptyslots[0].item=item
			emit_signal("updated_slot")
			return 1
		else:
			emit_signal("failed_update_slot")
			return 0

func use(item : InvItem) -> bool:
	var itemslots=slots.filter(func(slot) : return slot.item==item && slot.amount>0)
	if !itemslots.is_empty():
		itemslots[0].amount-=1
		emit_signal("updated_slot")
		return 1
	else:
		emit_signal("failed_update_slot")
		return 0

func use_ind(index: int)-> bool:
	if index<0 or index>slots.size():
		emit_signal("failed_update_slot")
		return 0
	else:
		if not(slots[index].amount==0 or slots[index]==null or slots[index].item==null):
			slots[index].amount-=1
			emit_signal("updated_slot")
			return 1
		else:
			emit_signal("failed_update_slot")
			return 0
		
