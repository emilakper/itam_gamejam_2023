extends Area2D

class_name Minigame

enum MinigameType {
	BLOOD,
	CORPSE
}

signal minigame_start
signal minigame_end(reward)

var is_active : bool = false

@export
var Settings: MinigameResource

@export
var CurrentlyActiveLineIndex: int

@export
var reward: int


# Called when the node enters the scene tree for the first time.
func _ready():
	Settings.parse()
	$Title.text = Settings.getTitle()

var characters_yet_achived: int = 0
var current_text: String
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	current_text = Settings.keycodes[CurrentlyActiveLineIndex]
	if not is_active:
		return
	
	
	

func start_minigame():
	emit_signal("minigame_start")
	is_active = true
	$Text.text = Settings.getTexts()[CurrentlyActiveLineIndex]
	$Text.show()
	# THIS WORKS BUT A SHIT SOLUTION 
	# MinigameThread.start(queue_stuff)

func recolor_character(index: int, is_correct: bool):
	var string: String = $Text.text
	var character = string[index]
	var copy_string = string
	$Text.clear()
	string = string.erase(index, string.length() - index )
	copy_string = copy_string.erase(0, index + 1)
	# Push green on all previous thingies that were done correctly
	$Text.push_color(Color.GREEN)
	$Text.append_text(string)
	$Text.pop()
	if (is_correct):
		$Text.push_color(Color.GREEN)
	else:
		$Text.push_color(Color.RED)
	$Text.append_text(character)
	$Text.pop()
	$Text.append_text(copy_string)
	
	
func _input(event):
	if not is_active:
		return
	if event is InputEventKey and event.is_pressed():
		queue_stuff(event.keycode)
	


func queue_stuff(scancode):
	var characters_to_achive: int = current_text.length()
	if characters_yet_achived < characters_to_achive:
		var keycode = OS.find_keycode_from_string(current_text[characters_yet_achived])
		if scancode == keycode:
			recolor_character(characters_yet_achived, true)
			characters_yet_achived += 1
			if characters_yet_achived == characters_to_achive:
				is_active = false
				minigame_end.emit(reward)
		else:
			recolor_character(characters_yet_achived, false)
	else:
		is_active = false
		emit_signal("minigame_end", reward)	



func _on_area_entered(area):
	if area.get_parent() is Hero: 
		var hero : Hero = area.get_parent()
		$Title.show()
		hero.show_interact_button(Hero.Interactables.MINIGAME)
		hero.setCurrentMinigame(self)

func _on_area_exited(area):
	if area.get_parent() is Hero: 
		var hero : Hero = area.get_parent()
		$Title.hide()
		hero.hide_interact_button(Hero.Interactables.MINIGAME)
		hero.setCurrentMinigame(null)
		


func _on_minigame_end(reward):
	$FreeTimer.start()


func _on_free_timer_timeout():
	queue_free()
