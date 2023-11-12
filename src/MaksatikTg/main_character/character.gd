extends Skeleton2D
@onready var bone = $hip
@onready var anim = $Animations
func _rotate():
	bone.apply_scale(Vector2(-1, 1))
