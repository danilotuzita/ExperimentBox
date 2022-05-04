extends Node2D
class_name EarthWall

onready var deployment_area = $DeploymentArea
onready var collision = $DeploymentArea/HitBoxCollision
onready var sprite = $DeploymentArea/HitBoxCollision/Sprite
onready var hitbox = $HitBoxBody
onready var timer = $Timer

export(Color) var preview_color = Color("cb3bbc28")
export(Color) var invalid_placement_color = Color("80ff0028")
export var lifetime: float = 3

var invalid_placement setget set_invalid_placement


func _ready():
	self.invalid_placement = false


func deploy() -> bool:
	if invalid_placement:
		return false
	sprite.modulate = Color.white
	deployment_area.remove_child(collision)
	hitbox.add_child(collision)
	timer.start(lifetime)
	return true


func _process(_delta):
	if not timer.is_stopped():
		sprite.self_modulate = Color(1, 1, 1, timer.time_left / lifetime)


# signals
func _on_Timer_timeout():
	queue_free()


func _on_Area2D_body_entered(_body):
	self.invalid_placement = true


func _on_Area2D_area_entered(_area):
	self.invalid_placement = true


func _on_Area2D_area_exited(_area):
	update_invalid_placement()


func _on_DeploymentArea_body_exited(_body):
	update_invalid_placement()


# setget
func set_invalid_placement(value):
	invalid_placement = value
	if invalid_placement:
		sprite.modulate = invalid_placement_color
	else:
		sprite.modulate = preview_color
	# print_debug("invalid_placement = ", invalid_placement)

# util
func update_invalid_placement():
	self.invalid_placement = ( # check if deployment_area has overlapping body or area
		deployment_area.get_overlapping_areas().size() or
		deployment_area.get_overlapping_bodies().size()
	)
