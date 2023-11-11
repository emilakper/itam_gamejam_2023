extends Area2D
var dialogue_free=true
func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _on_dialogue_ended(resource):
	print(resource)
	dialogue_free=true

func find_actions() -> void:
	var actionables=get_overlapping_areas()
	if actionables.size()>0:
		actionables[0].action()
		print("dialogue started")
		dialogue_free=false

func _process(delta):
	if Input.is_action_just_pressed("Speak") and dialogue_free==true:
		find_actions()



