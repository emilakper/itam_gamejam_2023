extends Node

signal cops_arrived

var time_talked_to_officer: int = 0

# Will work for now
var should_leave: bool = false

func move_to_shop():
	move_onto_other_level("res://shop/shop.tscn")

func cops_arrive():
	# get_tree().current_scene.find_children("*", "Officer")[0].show()
	cops_arrived.emit()

func move_onto_other_level(level_path: String):
	time_talked_to_officer = 0
	should_leave = false
	get_tree().change_scene_to_file(level_path)
