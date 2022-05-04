extends Node2D

# onready
onready var timer = $Timer
onready var path = $Path2D/PathFollow2D
onready var area = $Path2D/PathFollow2D/PunchArea
onready var hitbox_collision = $Path2D/PathFollow2D/PunchArea/HitBoxCollision

# export variables
export var life_time: float = .3
export var end_offset_time: float = .1
export var push_back_force: float = 250

# variables
var hit_bodies: Array = []


func _ready():
	timer.start(life_time + end_offset_time)


func _process(delta: float):
	path.unit_offset += (delta / life_time)
	
	var bodies = area.get_overlapping_bodies()
	for body in bodies:
		if hit_bodies.has(body): continue
		hit_bodies.append(body)
		
		if body is Pawn:
			handle_pawn(body)
			continue
		
		if body.get_parent() is EarthWall:
			handle_earth_wall(body.get_parent())
			continue


func handle_pawn(body: Pawn):
	var push_back_direction = Vector2.RIGHT.rotated(area.global_rotation)
	body.add_force(push_back_direction * push_back_force)


func handle_earth_wall(body: EarthWall):
	var new_time = body.timer.time_left - 2
	body.timer.start(max(new_time, .1))


func _on_Timer_timeout():
	queue_free()
