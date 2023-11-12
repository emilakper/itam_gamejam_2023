extends Node2D

func _draw():
	draw_rect(Rect2(0,0,1920,1080),Color(0,0,0))

func _ready():
	_draw()
	DialogueManager.dialogue_ended.connect(_on_boss_dialog_ended)
	get_child(0).action()
	
	
func _on_boss_dialog_ended(resource):
	print("leave scene")
