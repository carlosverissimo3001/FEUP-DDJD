class_name Player
extends CharacterBody2D

var screen_size
var direction = Macros.Direction.RIGHT
var powerups = [Macros.PowerUp.ELETRICAL]

var isFixingDoor: bool = false

@export var gravity = 1
@export var speed = 0

func _ready():
	screen_size = get_viewport_rect().size
	Signals.connect("eletric_door_spotted_engineer", _on_trying_to_fix_door)
	Signals.connect("eletric_door_is_fixed", _on_stopping_fixing_door)
	velocity.x = speed
	$AnimatedSprite2D.play()
	
func _on_trying_to_fix_door(name, door_name):
	if name != self.name:
		return
	if !powerups.has(Macros.PowerUp.ELETRICAL):
		return
	velocity.x = 0
	isFixingDoor = true
	#Play another animation
	Signals.emit_signal("eletric_door_is_being_fixed", door_name)
	
func _on_stopping_fixing_door(name):
	if name != self.name:
		return
	$AnimatedSprite2D.play("walk")
	isFixingDoor = false

func _physics_process(delta):
	if isFixingDoor:
		return
	velocity.y += gravity
	velocity.x = direction * speed
	
	move_and_slide()
	if is_on_wall() and velocity.x >= 0:
		direction = Macros.Direction.LEFT
		$AnimatedSprite2D.flip_h = true
	elif is_on_wall() and velocity.x < 0:
		direction = Macros.Direction.RIGHT
		$AnimatedSprite2D.flip_h = false

func _on_input_event(viewport, event, shape_idx):
	## Check if the player has been clicked on
	if (event is InputEventMouseButton && event.pressed):
		print("Clicked")

# On top of the platform
func _on_area_2d_area_entered(area):
	print("I'm on top of the platfrom\n")
	pass # Replace with function body.
