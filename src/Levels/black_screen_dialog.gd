extends Node2D

func _draw():
	draw_rect(Rect2(0,0,1920,1080),Color(0,0,0))

func _ready():
	_draw()
