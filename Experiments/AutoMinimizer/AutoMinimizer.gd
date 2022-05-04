extends Node2D

onready var label = $Label
onready var debugLabel = $DebugLabel
onready var minimizerTimer = $MinimizerTimer

const texts = [
	"WHY DID YOU WAKE ME??? I'M GOING TO SLEEP, LEAVE ME BE!",
	"COULD YOU STOP???",
	"STOP!",
	"STOP!!",
	"STOP!!!",
	"OH SO YOU'RE THESE TYPE OF PEOPLE HUH...",
	"OK THIS IS MY LAST WARNING, S.T.O.P!",
	"i told you..."
]

export(float) var minimize_time = .5
export(float) var letter_per_sec = 60
var current_text_index = 7
var bluescreen = false
var window_in_focus = true

func _ready():
	next_label(false) # setting up label
	OS.set_borderless_window(true) # setting up window

func _process(delta):
	if bluescreen: return
	
	var mouse = get_viewport().get_mouse_position()
	debugLabel.text = str(mouse)
	
	if window_in_focus: # not OS.is_window_minimized(): # se nao estiver minimizado
		if update_label(delta): # atualiza percentagem do label
			if minimizerTimer.time_left == 0:
				minimizerTimer.start(minimize_time)

func _notification(what):
	if what == MainLoop.NOTIFICATION_WM_FOCUS_IN:
		window_in_focus = true
	elif what == MainLoop.NOTIFICATION_WM_FOCUS_OUT:
		window_in_focus = false

func update_label(delta):
	var new_percentage = label.percent_visible + delta * (letter_per_sec / label.text.length())
	label.percent_visible = clamp(new_percentage, 0, 1)
	return new_percentage >= 1

func next_label(minimize = true):
	if current_text_index >= texts.size():
		bluescreen = true
		yield(get_tree().create_timer(1), "timeout")
		$BlueScreen.show()
		return
	label.text = texts[current_text_index]
	label.percent_visible = 0
	current_text_index += 1
	if minimize:
		OS.set_window_minimized(true)

func _on_MinimizerTimer_timeout():
	next_label()

func _on_BlueScreen_error_collection_completed():
	yield(get_tree().create_timer(1), "timeout")
	get_tree().quit()
