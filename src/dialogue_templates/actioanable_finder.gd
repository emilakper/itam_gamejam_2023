extends Area2D


var dialogue_free=true

signal dialogue_started(resource)

func _ready():
	DialogueManager.dialogue_ended.connect(_on_dialogue_ended)
	
func _on_dialogue_ended(resource):
	dialogue_free=true

func find_actions() -> void:
	var actionables=get_overlapping_areas()
	if actionables.size()>0:
		for i in actionables:
			if i is Actionable:
				i.action()
				emit_signal("dialogue_started",i.dialogue_resource)
				dialogue_free=false
				break

func _process(delta):
	if Input.is_action_just_pressed("Speak") and dialogue_free==true:
		find_actions()



