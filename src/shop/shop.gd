extends Control

signal purchased_item(item_name);

func get_money_val() -> float:
	return 500
	
func set_money_val(val : float):
	pass

func _on_leave_button_pressed():
	State.move_onto_other_level("res://Levels/1lvl.tscn")


var item_array
var money : float
var selected_item_id : int

func _enter_tree():
	load_items()
	money=get_money_val()
	get_child(0).select(0)
	_on_item_list_item_selected(0)
	update_purchase_button()
	update_balance_text()
	
func _exit_tree():
	set_money_val(money)

func load_items():
	var file = FileAccess.open("res://shop/shop_tems.json", FileAccess.READ)
	var content = file.get_as_text()
	item_array=JSON.parse_string(content)
	var item_list=get_child(0)
	for item in item_array:
		item_list.add_item(item["name"])

func update_purchase_button():
	get_child(2).disabled= not money>=item_array[selected_item_id]["price"]

func update_balance_text():
	get_child(3).text="Balance:  $" + str(money)
		




	
func _on_item_list_item_selected(index):
	selected_item_id=index
	update_purchase_button()
	var description_window=get_child(1)
	var item=item_array[index]
	$CenterContainer/Panel/Item.texture=load("res://item_images/"+item["image_name"] + ".png")
	description_window.clear()
	description_window.push_italics()
	description_window.push_font_size(26)
	description_window.append_text(item["name"] + " :   $"  + str(item["price"]))
	description_window.pop()
	description_window.pop()
	description_window.push_font_size(20)
	description_window.append_text("\n\n" + item["description"])


func purchase_item():
	emit_signal("purchased_item", item_array[selected_item_id]["image_name"])
	money-=item_array[selected_item_id]["price"]
	update_purchase_button()
	update_balance_text()


