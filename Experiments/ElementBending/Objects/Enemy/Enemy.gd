extends Pawn

onready var health_progress_bar: ProgressBar = $HealthProgressBar


func _ready():
	friction = 700
	stats.connect_health_progress_bar(health_progress_bar)
	stats.max_health = 9999
	stats.heal_to_max()
	var _error = stats.connect("died", self, "queue_free")
	

func _physics_process(delta: float):
	process_movement(delta)
	$Velocity.points[1] = final_velocity / 10
	$Movement.points[1] = movement_force / 10
	$Inertia.points[1] = inertia_force / 10
	var collision = get_last_slide_collision()
	if collision:
		$CollisionNormal.points[1] = collision.normal * 50

