extends StaticBody2D

class_name Officer

func _on_dialogue_started():
	$SpeakingSfx.play()
# Called when the node enters the scene tree for the first time.
func _ready():
	$Actionable.dialogue_started_action.connect(_on_dialogue_started)
	State.cops_arrived.connect(_on_cops_arrived)
	$officer.get_node("Animation").play("idle")


func _on_cops_arrived():
	$Actionable.monitoring = true
	$Actionable.monitorable = true
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
