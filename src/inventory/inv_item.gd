extends Resource

class_name InvItem

@export var name : String = ""
@export var texture : Texture2D

static func get_item(name : String) -> InvItem:
	var res : InvItem
	res.name=name
	res.texture=load("res://inventory/items/" + name + ".png")
	return res
