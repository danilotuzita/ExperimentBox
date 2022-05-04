extends Node2D
class_name CooldownHandler

var default_cooldown_time: float = 1
var number_of_cooldowns: int = 0 setget set_number_of_cooldowns
var cooldowns: Array = []

## PUBLIC FUNCTIONS ##
func init(number_cooldowns: int, cooldown_time: float = 1):
	default_cooldown_time = cooldown_time
	self.number_of_cooldowns = number_cooldowns


# UTILS
func create_cooldown(time: float):
	cooldowns.append(_create_timer(time))
	number_of_cooldowns += 1


func get_cooldown() -> Timer:
	for cooldown in cooldowns:
		if cooldown.time_left == 0:
			return cooldown
	return null


# SETGET
func set_number_of_cooldowns(value: int):
	number_of_cooldowns = value
	cooldowns.resize(number_of_cooldowns)
	for i in range(number_of_cooldowns):
		if not cooldowns[i]:
			cooldowns[i] = _create_timer(default_cooldown_time)


## PRIVATE FUNCTIONS ##
# UTILS
func _create_timer(time: float) -> Timer:
	var timer = Timer.new()
	timer.one_shot = true
	timer.wait_time = time
	add_child(timer)
	return timer
