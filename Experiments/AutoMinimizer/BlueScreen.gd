extends Node2D

onready var size = 10000
onready var background = $Background
onready var control = $Control
onready var percentage = $Control/HBoxContainer/VBoxContainer/Percentage
onready var errorTimer = $ErrorTimer
onready var window_pos = Vector2(-size / 2, -size / 2)
onready var face_pos = -window_pos + Vector2(128, 128) # OS.get_screen_size() * Vector2(128 / 720, 128 / 1280)

var rng = RandomNumberGenerator.new()
var error_collection_percentage = 0
var error_collection_time_range = [.7, .9]

signal error_collection_completed

func _ready():
	rng.randomize()
	visible = false

func show():
	visible = true
	expand_background()
	Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)

func expand_background():
	background.margin_right = size
	background.margin_bottom = size
	OS.set_window_size(Vector2(size, size))
	OS.set_window_position(window_pos)
	OS.set_window_always_on_top(true)
	control.set_position(face_pos)
	start_error_timer()

func start_error_timer():
	errorTimer.start(
		rand_range(
			error_collection_time_range[0],
			error_collection_time_range[1]
		)
	)

func select_new_percentage():
	error_collection_percentage = min(
		error_collection_percentage + rng.randi_range(2, 25), 
		100
	)
	percentage.text = str(error_collection_percentage) + "% Complete"
	if error_collection_percentage >= 100:
		emit_signal("error_collection_completed")
	else:
		start_error_timer()

func _on_ErrorTimer_timeout():
	if visible:
		select_new_percentage()
