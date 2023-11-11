extends MarginContainer


@onready
var minigame_settings : MinigameSettings = get_parent().MGSettings
@onready
var cops_timer : CopsTimer = get_parent().cops_timer

@onready 
var CleaningProgress = $HBoxContainer/Bars/Bar/ProgressBar
@onready
var timer: RichTextLabel = $HBoxContainer/Bars/Timer

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.text += "[shake]"
	timer.bbcode_enabled = true
	cops_timer.start()
	CleaningProgress.max_value = minigame_settings.count_max_points() # 100%
	
func _process(delta):
	var pos = timer.text.find("]") 
	
	timer.text = timer.text.erase(pos + 1, timer.text.length() - pos - 1)	

	if (cops_timer.time_left() / 60 == 0):
		timer.add_theme_color_override("default_color", Color.RED)
	else:
		timer.remove_theme_color_override("default_color")
		
	var seconds: String = str(cops_timer.time_left() % 60)
	if (seconds.length() == 1):
		seconds = "0" + seconds
	timer.text += (str(cops_timer.time_left() / 60) + ":" + seconds)
	

func apply_award(award: int):
	CleaningProgress.value -= award

