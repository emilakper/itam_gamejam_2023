extends RigidBody2D


@export
var hero: Hero

# Called when the node enters the scene tree for the first time.
func _ready():
	hero.connect("entered_door", _on_hero_entered_door)
	hero.connect("exited_door", _on_hero_entered_door)

func _on_hero_entered_door():
	if (collision_layer == 256):
		collision_layer =  0
	else:
		collision_layer = 256

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
