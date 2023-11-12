extends Node2D

class_name MinigameSettings

var Minigames: Array[Node] = []

var MaxPoints: int

func count_max_points() -> int:
	if MaxPoints == 0:
		var max_points: int = 0
		for i in get_minigames():
			max_points += i.reward
		MaxPoints = max_points
	return MaxPoints

func get_minigames() -> Array[Node]:
	if (Minigames.size() == 0):
		
		Minigames = get_tree().current_scene.find_children("*", "Minigame")
		return Minigames
	else:
		return Minigames
# Called when the node enters the scene tree for the first time.
func _ready():
	count_max_points()
	get_minigames() # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
