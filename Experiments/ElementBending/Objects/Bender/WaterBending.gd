extends Bending
class_name WaterBending
var WaterPunch = preload("res://Experiments/ElementBending/Objects/WaterPunch/WaterPunch.tscn")


func init(parent: Node2D) -> void:
	base_init(parent)


func create_water_punch(position: Position2D, parent_node: Node2D) -> Node2D:
	var water_punch = WaterPunch.instance()
	parent_node.add_child(water_punch)
	water_punch.global_position = position.global_position
	water_punch.global_rotation = position.global_rotation
	water_punch.scale = position.scale
	return water_punch
