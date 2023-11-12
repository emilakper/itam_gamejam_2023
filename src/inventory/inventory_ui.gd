extends Control

@export var inv_size : int = 5
@onready var inv : Inv = preload("res://inventory/global_inventory.tres")
@onready var ui_slots = get_children()



func _ready():
	inv.updated_slot.connect(update_slots)
	update_slots()

func update_slots():
	for i in range(0,inv_size):
		ui_slots[i].update(inv.slots[i])
		
func open():
	visible=true
	
func close():
	visible=false
