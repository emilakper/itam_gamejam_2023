extends Node2D

func _ready():
	MusicController.play_music()
func _on_start_pressed():
	get_tree().change_scene_to_file("res://Levels/black_screen_dialog.tscn")


func _on_quit_pressed():
	get_tree().quit()
	


func _on_settings_pressed():
	get_tree().change_scene_to_file("res://UI/Settings Menu/settings.tscn")
