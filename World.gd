extends Node2D

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func _input(event):
	if event.is_action_type():
		get_tree().quit(1)
	if event is InputEventMouseButton:
		get_tree().quit(1)
	if event is InputEventMouseMotion:
		if event.relative.x >= 15 or event.relative.y >= 15 or event.relative.y <= -15 or event.relative.x <= -15:
			get_tree().quit(1)
