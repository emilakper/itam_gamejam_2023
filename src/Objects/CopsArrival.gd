extends Timer

class_name CopsTimer

signal cops_arrived

@export
var base_wait_time: int

var time_elapsed: int

func get_time_elapsed() -> int:
	return time_elapsed
	
func time_left() -> int:
	return base_wait_time - time_elapsed


# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if time_left() < 0:
		State.cops_arrive()
		# cops_arrived.emit()


func _on_timeout():
	time_elapsed += 1
	
