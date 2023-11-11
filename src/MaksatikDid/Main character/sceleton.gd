extends Skeleton2D


@onready var anim = $AnimationPlayer
@onready var bones2d_node = $character
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if (Input.is_action_just_pressed("MoveRight")):
		$AnimationPlayer.play("idle")
