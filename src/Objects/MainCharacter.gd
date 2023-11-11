extends CharacterBody2D

class_name Hero

signal entered_door
signal exited_door


@export
var speed : float = 300.0
@export 
var Background: TileMap = null
@export 
var Foreground: TileMap = null
@export
var MGSettings: MinigameSettings
@export
var cops_timer: CopsTimer

var CurrentStairs: Stairs = null



# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_inside: bool = false
var should_block_input: bool = false


# !!!DANGER!!! HIHGLY DEPENDANT ON THE PROJECT OPTIONS
const COLLISION_BASE_LAYER : int = 1
const COLLISION_OUTSIDE_LAYER : int = pow(2, 1) 
const COLLISION_INSIDE_LAYER : int = pow(2, 2) 
const COLLISION_HERO_LAYER : int = 256



var CurrentMinigame: Minigame = null

func setCurrentMinigame(value):
	CurrentMinigame = value

func __connect_signals_of_type(node_type: String, signal_name:String, handler_name:Callable) -> void:
	var nodes: Array[Node] = get_parent().find_children("*", node_type)
	for i in nodes:
		i.connect(signal_name, handler_name)
		
func _ready():
	cops_timer.connect("cops_arrived", _on_cops_arrived)
	__connect_signals_of_type("Minigame", "minigame_start", _on_minigame_start)
	__connect_signals_of_type("Minigame", "minigame_end", _on_minigame_end)
	
func block_input() -> void:
	should_block_input = true
	
func unblock_input() -> void:
	should_block_input = false

func _on_minigame_start() -> void:
	block_input()
	
func _on_cops_arrived():
	get_tree().quit()
	
func _on_minigame_end(reward) -> void:
	unblock_input()
	$GUI.apply_award(reward)
	CurrentMinigame = null
	

func darken_foreground(foreground: TileMap, how_much: float) -> Color:
	var foreground_color : Color = foreground.modulate
	foreground_color = foreground_color.darkened(how_much)
	return foreground_color
	
	
func lighten_foreground(foreground: TileMap, how_much: float) -> Color:
	var foreground_color : Color = foreground.modulate
	foreground_color = foreground_color.lightened(how_much)
	return foreground_color
	
func show_background(background: TileMap) -> void:
	background.show()

func hide_background() -> void:
	pass

func set_collisions_to(masks: int) -> void:
	collision_layer = masks | COLLISION_HERO_LAYER
	collision_mask = collision_layer
	
	
func enter_door():
	Foreground.modulate = darken_foreground(Foreground, 0.5)
	set_collisions_to(COLLISION_INSIDE_LAYER | COLLISION_BASE_LAYER)
	$DoorPopup.hide()
	$DoorPopup.text = "S"
	show_background(Background)
	is_inside = true
	emit_signal("entered_door") 

func exit_door():
	# wtf?? Why is it not 0.5 huh???? Ok.
	Foreground.modulate = lighten_foreground(Foreground, 1)
	set_collisions_to(COLLISION_OUTSIDE_LAYER | COLLISION_BASE_LAYER)
	$DoorPopup.hide()
	$DoorPopup.text = "W"
	hide_background()
	is_inside = false
	emit_signal("exited_door")

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	
	if should_block_input:
		return
	
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("MoveLeft", "MoveRight")
	if direction:
		velocity.x = direction * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
	move_and_slide()

func _process(_delta):
	if should_block_input:
		return
	if Input.is_action_pressed("EnterDoor") and $DoorPopup.visible and not is_inside:
		enter_door()
	if Input.is_action_just_pressed("LeaveDoor") and $DoorPopup.visible and is_inside:
		exit_door()
	# Change a bit
	# maybe move it later
	if Input.is_action_just_pressed("EnterDoor") and $MinigamePopup.visible and CurrentMinigame != null:
		CurrentMinigame.start_minigame()
		$MinigamePopup.hide()
	
	if Input.is_action_just_pressed("EnterDoor") and $StairsPopup.visible and CurrentStairs != null:
		CurrentStairs.teleport_to_other_side(self)

# The body will always be a door since the DoorChecker's mask is set to
# be on the door layer 
func _on_door_checker_body_entered(body):
	show_interact_button(Interactables.DOOR)
	

func _on_door_checker_body_exited(body):
	hide_interact_button(Interactables.DOOR)
		
enum Interactables {
	DOOR,
	MINIGAME
}

func show_interact_button(which_button: Interactables):
	var popup : Node
	match which_button:
		Interactables.DOOR:
			popup = $DoorPopup
		Interactables.MINIGAME:
			popup = $MinigamePopup
	popup.show()
	
func hide_interact_button(which_button: Interactables):
	var popup : Node
	match which_button:
		Interactables.DOOR:
			popup = $DoorPopup
		Interactables.MINIGAME:
			popup = $MinigamePopup
	popup.hide()



func _on_stairs_checker_area_entered(area: Stairs):
	CurrentStairs = area
	$StairsPopup.show()


func _on_stairs_checker_area_exited(area):
	CurrentStairs = null
	$StairsPopup.hide()
