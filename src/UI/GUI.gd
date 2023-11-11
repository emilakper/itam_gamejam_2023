extends MarginContainer


@onready
var minigame_settings : MinigameSettings = get_parent().MGSettings
@onready 
var CleaningProgress = $HBoxContainer/Bars/Bar/ProgressBar

# Called when the node enters the scene tree for the first time.
func _ready():
	CleaningProgress.max_value = minigame_settings.count_max_points() # 100%
	
func apply_award(award: int):
	CleaningProgress.value -= award

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
