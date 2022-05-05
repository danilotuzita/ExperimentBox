extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 14
export var rot_speed = 15
export var fall_acceleration = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var rot_input = Input.get_vector("ui_left", "ui_right", "ui_up", "ui_down")
	rotation.y += rot_input.x * rot_speed * delta
	rotation.x += rot_input.y * rot_speed * delta
	rotation.x = clamp(rotation.x, -PI/4, PI/4)


	var mov_input = Input.get_vector("action_left", "action_right", "action_up", "action_down")
	var dir = Vector3(mov_input.x, 0, mov_input.y)
	var velocity = dir * speed
	velocity.y -= fall_acceleration * delta


	move_and_slide(velocity, Vector3.UP)
