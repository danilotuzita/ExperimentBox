extends KinematicBody


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
export var speed = 7
export var rot_speed = 15
export var fall_acceleration = 250

onready var mesh = $CollisionShape/MeshInstance


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	var rot_input = Input.get_vector("ui_right", "ui_left", "ui_up", "ui_down")
	rotation.y += rot_input.x * rot_speed * delta
	rotation.x += rot_input.y * rot_speed * delta
	rotation.x = clamp(rotation.x, -PI/4, PI/4)

	var mov_input = Input.get_vector("action_left", "action_right", "action_up", "action_down")
	var dir = Vector3(mov_input.x, 0, mov_input.y)
	var velocity = dir * speed
	velocity.y -= fall_acceleration * delta

	# print_debug(rotation.y)
	var lin_vel = move_and_slide(velocity.rotated(Vector3.UP, rotation.y), Vector3.UP, true)

	#mesh.rotate(lin_vel.normalized(), lin_vel.length() * delta * speed)
