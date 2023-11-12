extends Area2D
class_name Actionable

@export var dialogue_resource: DialogueResource
@export var dialogue_start: String= "start"

signal dialogue_started_action

func action() -> void:
	dialogue_started_action.emit()
	DialogueManager.show_example_dialogue_balloon(dialogue_resource,dialogue_start)
