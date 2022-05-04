extends KinematicBody2D
class_name Pawn

# private variables
var final_velocity: Vector2
var current_velocity: Vector2
var inertia_force: Vector2
var movement_force: Vector2

# export variables
export var walk_speed: float = 100
export var run_speed: float = 100
export var friction: float = 500
export var max_inertia: float = 2500

export var can_take_collision_damage: bool = true
export var collision_damage: float = 5
export var min_spd_col_dmg: float = 1000

var _min_spd_col_dmg2: float

var stats: Stats = Stats.new()

func _ready():
	# squaring speeds to length calculations faster
	_min_spd_col_dmg2 = pow(min_spd_col_dmg, 2)


func process_movement(delta: float):
	current_velocity = final_velocity
	final_velocity = move_and_slide(inertia_force + movement_force)
	inertia_force = inertia_force.move_toward(Vector2.ZERO, delta * friction)
	if can_take_collision_damage:
		check_for_collision_damage()


func check_for_collision_damage():
	var collision = get_last_slide_collision()
	if collision:
		if current_velocity.length_squared() > _min_spd_col_dmg2:
			print_debug("Normal: ", collision.normal)
			#inertia_force += collision.normal * min_spd_col_dmg
			inertia_force = Vector2.ZERO
			take_damage(collision_damage)


func walk(direction: Vector2):
	move(direction, walk_speed)


func run(direction: Vector2):
	move(direction, run_speed)


func move(direction: Vector2, speed: float):
	movement_force = speed * direction.normalized()


func add_force(force: Vector2):
	inertia_force += force
	inertia_force = inertia_force.clamped(max_inertia)


func get_direction() -> Vector2:
	return final_velocity.normalized()


func take_damage(value: float):
	stats.take_damage(value)
