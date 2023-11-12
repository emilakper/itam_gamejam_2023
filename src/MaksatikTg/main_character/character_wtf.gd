extends Skeleton2D
class_name CharacterSkeleton

@onready var bone = $hip
@onready var anims = $AnimationPlayer


func _read():
	print(anims)

func flip():
	bone.apply_scale(Vector2(-1, 1))

func facing_right():
	return bone.scale.x < 0
	
func facing_left():
	return bone.scale.x >= 1

