extends Node

@onready var background_player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()
#@onready var sfx_player: AudioStreamPlayer2D = AudioStreamPlayer2D.new()

func play_bgm_loop():
	var track = load("res://Music/backmusic.mp3")
	background_player.stream = track
	background_player.play()

func _ready():
	background_player.bus = "Music"
	get_tree().current_scene.add_child(background_player)
	# get_tree().current_scene.add_child(sfx_player)
	play_bgm_loop()
