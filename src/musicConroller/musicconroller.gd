extends Node

var music = load("res://Music/backmusic.mp3")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func play_music():
	$Music.stream = music
	$Music.play()