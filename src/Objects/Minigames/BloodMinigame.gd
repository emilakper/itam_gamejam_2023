extends Area2D

enum MinigameType {
	BLOOD,
	CORPSE
}

signal minigame_start
signal minigame_end

@export
var Settings: MinigameResource


# Called when the node enters the scene tree for the first time.
func _ready():
	Settings.parse()
	$Label.text = Settings.getTitle()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func start_minigame():
	emit_signal("minigame_start")

func _on_area_entered(area):
	if area.get_parent() is Hero: 
		var hero : Hero = area.get_parent()
		$Label.show()
		hero.show_interact_button(Hero.Interactables.MINIGAME)
		


func _on_area_exited(area):
	if area.get_parent() is Hero: 
		var hero : Hero = area.get_parent()
		$Label.hide()
		hero.hide_interact_button(Hero.Interactables.MINIGAME)
