extends Area2D

class_name Stairs

@export
var OtherSide: Stairs


## Since there can only be one hero
#@onready
#var hero: Hero = get_parent().find_children("*", "Hero")[0]

func teleport_to_other_side(object: Node2D) -> void:
	object.position = OtherSide.position

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
