extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	visible=false
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_main_character_entered_door():
	visible=true


func _on_main_character_exited_door():
	visible=false
