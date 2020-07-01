extends Node2D

onready var background = $Background

func _ready():
	visible = false

func show():
	visible = true
	#OS.set_window_size(OS.get_screen_size())
	#OS.set_window_position(Vector2(0, 0))
	OS.set_window_always_on_top(true)
	OS.set_window_fullscreen(true)
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
