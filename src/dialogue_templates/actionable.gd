extends Area2D
class_name Actionable

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String= "start"



func action() -> void:
	DialogueManager.show_example_dialogue_balloon(dialogue_resource,dialogue_start)
