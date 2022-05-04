class_name Stats

var max_health: float = 1 setget set_max_health
var health: float = 1 setget set_health

signal died()
signal max_health_updated(max_health)
signal health_updated(health)

# COMMON FUNCTIONS
func take_damage(value: float):
	self.health -= value

func heal(value: float):
	self.health += value

func heal_to_max():
	self.health = max_health


# UTILS
func connect_health_progress_bar(progress_bar: ProgressBar):
	var _error1 = connect("max_health_updated", progress_bar, "set_max")
	var _error2 = connect("health_updated", progress_bar, "set_value")


# SETGET
func set_max_health(value: float):
	if max_health <= 0:
		return
	max_health = value
	emit_signal("max_health_updated", max_health)

func set_health(value: float):
	health = min(value, max_health)
	emit_signal("health_updated", health)
	if health <= 0:
		emit_signal("died")
