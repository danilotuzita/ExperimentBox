extends Bending
class_name FireBending
var FireBall = preload("res://Experiments/ElementBending/Objects/FireBall/FireBall.tscn")


func init(parent: Node2D) -> void:
	base_init(parent)


func create_fireball(position: Position2D, parent_node: Node2D) -> Node2D:
	var fireball: Node2D = FireBall.instance()
	parent_node.add_child(fireball)
	fireball.global_position = position.global_position
	fireball.global_rotation = position.global_rotation
	fireball.init(_parent)
	return fireball
