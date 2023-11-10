extends CharacterBody2D

@export
var speed : float = 300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_inside: bool = false


# !!!DANGER!!! HIHGLY DEPENDANT ON THE PROJECT OPTIONS
const COLLISION_BASE_LAYER : int = 1
const COLLISION_OUTSIDE_LAYER : int = pow(2, 1) 
const COLLISION_INSIDE_LAYER : int = pow(2, 2) 


func enter_door():
	var foreground_color : Color = %Foreground.modulate
	foreground_color = foreground_color.darkened(0.5)
	%Foreground.modulate = foreground_color 
	is_inside = true
	collision_layer = COLLISION_INSIDE_LAYER | COLLISION_BASE_LAYER
	collision_mask = collision_layer
	light_mask = collision_layer
	visibility_layer = collision_layer
	$DoorPopup.hide()
	%Background.show()


func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()

func _process(_delta):
	if Input.is_action_pressed("EnterDoor") and $DoorPopup.visible and not is_inside:
		enter_door()

# The body will always be a door since the DoorChecker's mask is set to
# be on the door layer 
func _on_door_checker_body_entered(body):
	if not is_inside:
		$DoorPopup.show()

func _on_door_checker_body_exited(body):
	$DoorPopup.hide()
