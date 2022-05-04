extends KinematicBody2D

# variables
var parent: Node2D = null
var velocity = Vector2.ZERO

# export variables
export var speed = 500
export var damage = 2
export var push_back_force = 250


func init(parent_node: Node2D):
	parent = parent_node
	velocity = Vector2(speed, 0).rotated(rotation)


func _physics_process(delta: float):
	var collision = move_and_collide(velocity * delta)
	if collision:
		var other_body: Node2D = collision.collider
		if other_body is Pawn:
			var push_back_direction = (other_body.global_position - parent.global_position).normalized()
			other_body.add_force(push_back_direction * push_back_force)
			other_body.take_damage(damage)
		queue_free()


func _on_Timer_timeout():
	queue_free()
