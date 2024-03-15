extends Camera2D

var cursor = preload("res://art/cursor/mouse.png")

var zoom_min = Vector2(0.8001, 0.8001)
var zoom_max = Vector2(2 ,2)
var zoom_speed = Vector2(.2, .2)
var des_zoom = zoom

var _target_zoom : float = 1.0
const MIN_ZOOM  : float = 1.0
const MAX_ZOOM  : float = 2.0
const ZOOM_INC  : float = 0.2
const ZOOM_RATE : float = 8.0

func _physics_process(delta):
	zoom = lerp(zoom, _target_zoom * Vector2.ONE, ZOOM_RATE * delta)
	
#func _process(delta):
	#zoom = lerp(zoom, des_zoom, 0.2)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _input(event):
	pass

func _unhandled_input(event: InputEvent) -> void:
	# panning
	if event is InputEventMouseMotion:
		if event.button_mask == MOUSE_BUTTON_MASK_MIDDLE:
			#Input.set_custom_mouse_cursor(cursor, Input.CURSOR_ARROW, Vector2(16, 16))
			_pan(event)
	# zooming
	if event is InputEventMouseButton:
		if event.is_pressed():
			if event.button_index == MOUSE_BUTTON_WHEEL_DOWN:
				_zoom_in()
			if event.button_index == MOUSE_BUTTON_WHEEL_UP:
				_zoom_out()

func _pan(event):
	position -= event.relative * zoom

func _zoom_in():
	_target_zoom = max(_target_zoom - ZOOM_INC, MIN_ZOOM)
	set_physics_process(true)
	
	#if zoom > zoom_min:
		#if ((des_zoom - zoom_speed) > zoom_min):
			#des_zoom -= zoom_speed
	
func _zoom_out():
	_target_zoom = min(_target_zoom + ZOOM_INC, MAX_ZOOM)
	set_physics_process(true)
	#if zoom < zoom_max:
		#des_zoom += zoom_speed
