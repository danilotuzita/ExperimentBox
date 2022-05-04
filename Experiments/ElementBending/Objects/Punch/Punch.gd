extends Area2D

# onready
onready var timer = $Timer

# export variables
export var life_time: float = .1
export var push_back_force: float = 50
export var damage: float = 1

# private variables
var direction: Vector2
var parent: Pawn


func _ready():
	timer.start(life_time)


func setup(position: Position2D, parent_node: Pawn = null):
	global_position = position.global_position
	global_rotation = position.global_rotation
	direction = Vector2.RIGHT.rotated(rotation) * 500
	scale *= position.scale
	parent = parent_node


func _physics_process(delta):
	position += direction * delta


func _on_Timer_timeout():
	queue_free()


func _on_PunchArea_body_entered(body):
	if body == parent:
		return
	
	if body is Pawn:
		var push_back_direction = (body.global_position - parent.global_position).normalized()
		body.add_force(push_back_direction * push_back_force)
		body.take_damage(damage)
	
	queue_free()
