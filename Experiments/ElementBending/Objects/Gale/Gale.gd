extends Node2D

# onready variables
onready var timer = $Timer
onready var area = $AreaOfEffect
onready var collision = $AreaOfEffect/HitboxCollision
onready var direction_sprite = $AreaOfEffect/ArrowSprite
onready var gale_sprite = $AreaOfEffect/GaleSprite

# export variables
export var life_time: float = 3
export var initial_wind_force: float = 300
export var wind_force: float = 1000
export var auto_deploy: bool = false

# private variables
var parent: Node2D
var wind_direction: Vector2


func _ready():
	collision.disabled = true
	if auto_deploy:
		deploy()


func _physics_process(delta):
	for body in area.get_overlapping_bodies():
		apply_force_to_body(body, wind_force * delta)


func deploy():
	timer.start(life_time)
	collision.disabled = false
	direction_sprite.visible = false
	gale_sprite.visible = true
	wind_direction = Vector2.RIGHT.rotated(global_rotation) 


func apply_force_to_body(body: Node2D, force: float):
	if body is Pawn and body != parent:
		body.add_force(wind_direction * scale.x * force)


func _on_Timer_timeout():
	queue_free()


func _on_AreaOfEffect_body_entered(body: Node2D):
	apply_force_to_body(body, initial_wind_force)
