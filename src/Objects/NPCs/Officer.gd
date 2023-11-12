extends StaticBody2D

class_name Officer
# Called when the node enters the scene tree for the first time.
func _ready():
	State.cops_arrived.connect(_on_cops_arrived)
	$officer.get_node("Animation").play("idle")


func _on_cops_arrived():
	$Actionable.monitoring = true
	$Actionable.monitorable = true
	show()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
