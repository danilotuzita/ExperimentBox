extends Bending
class_name WindBending
var Gale = preload("res://Experiments/ElementBending/Objects/Gale/Gale.tscn")

# variables
var undeployed_gale: Node2D


func init(parent: Node2D) -> void:
	base_init(parent)


func create_gale(position: Position2D, inverted: bool, parent_node: Node2D):
	if undeployed_gale:
		undeployed_gale.queue_free()
	var gale: Node2D = Gale.instance()
	parent_node.add_child(gale)
	gale.global_position = position.global_position
	gale.global_rotation = position.global_rotation
	gale.parent = _parent
	gale.scale.x = -1 if inverted else 1
	undeployed_gale = gale


func deploy_gale(parent_node: Node2D):
	if not undeployed_gale:
		return
	var current_position = undeployed_gale.global_position
	var current_rotation = undeployed_gale.global_rotation
	var current_parent = undeployed_gale.get_parent()
	current_parent.remove_child(undeployed_gale)
	parent_node.add_child(undeployed_gale)
	undeployed_gale.global_position = current_position
	undeployed_gale.global_rotation = current_rotation
	undeployed_gale.deploy()
	undeployed_gale = null
