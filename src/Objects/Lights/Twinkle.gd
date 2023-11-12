extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Timer.start()
	randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_timer_timeout():
	var time: float = float(randi_range(10, 15)) / 10
	if enabled:
		enabled = false
	else:
		enabled = true
	$Timer.start(time)
