extends Control

@export var inv_size : int = 5
@export var inv : Inv
@onready var ui_slots = get_children()



func _ready():
	inv.updated_slot.connect(update_slots)
	update_slots()
	inv.add(InvItem.get_item("blood"))
	inv.add(InvItem.get_item("hair"))
	
	inv.use(InvItem.get_item("blood"))
	
	inv.add(InvItem.get_item("bag"))
	inv.add(InvItem.get_item("blood"))
	inv.add(InvItem.get_item("blood"))
	inv.add(InvItem.get_item("empty_bag"))

func update_slots():
	for i in range(0,inv_size):
		ui_slots[i].update(inv.slots[i])
		
func open():
	visible=true
	
func close():
	visible=false
