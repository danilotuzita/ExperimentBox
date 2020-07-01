extends Node2D

export(float) var minimize_time = 1.5
export(float) var label_time = .05
onready var timer = $Timer
onready var label = $Label
onready var labelTick = $LabelTick
onready var debugLabel = $DebugLabel

const texts = [
	["WHY DID YOU WAKE ME??? I'M GOING TO SLEEP, LEAVE ME BE!", 1.5],
	["COULD YOU STOP???", 1],
	["STOP!", 0.5],
	["STOP!!", 0.5],
	["STOP!!!", 0.5],
	["OH SO YOU'RE THESE TYPE OF PEOPLE HUH...", 1.5],
	["OK THIS IS MY LAST WARNING, S.T.O.P!", 1.5],
	["i told you...", .1]
]

var current_text_index = 7
var text_count = 0
var text_pos = 0

var test = true
var test2 = true

func _ready():
	timer.stop()
	text_count = texts.size()
	label.text = ""
	OS.set_borderless_window(true)

func _process(delta):
	var mouse = get_viewport().get_mouse_position()
	debugLabel.text = str(mouse)
	
	if !test:
		if test2:
			$BlueScreen.show()
			test2 = false
		return
	
	if !OS.is_window_minimized():
		if update_label():
			if timer.is_stopped():
				timer.start(texts[current_text_index][1])

func update_label():
	if !labelTick.is_stopped():
		return false
	
	labelTick.start(label_time)
	var current_text = texts[current_text_index][0]
	if text_pos < current_text.length():
		label.text += current_text[text_pos]
		text_pos += 1
		return false
	return true

func next_label():
	label.text = ""
	text_pos = 0
	current_text_index += 1
	if current_text_index >= texts.size():
		test = false

func _on_Timer_timeout():
	# return
	next_label()
	if test:
		OS.set_window_minimized(true)
