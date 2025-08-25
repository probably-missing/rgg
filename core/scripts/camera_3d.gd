@tool
extends Camera3D

var controlable = true
const MOUSE_SENSITIVITY = 0.002

func _ready() -> void:
	# Capture the mouse cursor for first-person controls
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _input(event: InputEvent) -> void:
	if controlable == true:
		# Handle mouse look
		if event is InputEventMouseMotion and Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			# Rotate parent horizontally (yaw)
			get_parent().rotate_y(-event.relative.x * MOUSE_SENSITIVITY)
		
			# Rotate camera vertically (pitch)
			rotate_object_local(Vector3.RIGHT, -event.relative.y * MOUSE_SENSITIVITY)
		
			# Clamp vertical rotation to prevent flipping
			rotation.x = clamp(rotation.x, deg_to_rad(-90), deg_to_rad(90))

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.get_mouse_mode() == Input.MOUSE_MODE_CAPTURED:
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
		else:
			Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)
