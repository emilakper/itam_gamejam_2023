extends Node

signal cops_arrived


var did_cops_arrive: bool = false

var time_talked_to_officer: int = 0

# Will work for now
var should_leave: bool = false

var current_points: int = 0

func fadein(speed_mult: float = 1):
	var colorrectplayer: AnimationPlayer = get_tree().current_scene.find_child("ColorRect").get_child(0)
	colorrectplayer.speed_scale *= speed_mult
	colorrectplayer.queue("fadein")

func fadeout(speed_mult: float = 1):
	var colorrectplayer: AnimationPlayer = get_tree().current_scene.find_child("ColorRect").get_child(0)
	colorrectplayer.speed_scale *= speed_mult
	colorrectplayer.queue("fadeout")

func move_to_shop():
	move_onto_other_level("res://shop/shop.tscn")

func cops_arrive():
	# get_tree().current_scene.find_children("*", "Officer")[0].show()
	var timer := Timer.new()
	get_tree().current_scene.add_child(timer)
	timer.timeout.connect(__on_timer_timeout)
	timer.wait_time = 0.5
	timer.one_shot = true
	timer.start()
	
func __on_timer_timeout():
	cops_arrived.emit()
	did_cops_arrive = true

func move_onto_other_level(level_path: String):
	time_talked_to_officer = 0
	should_leave = false
	get_tree().change_scene_to_file(level_path)
