extends Bending
class_name EarthBending
var EarthWallScene = preload("res://Experiments/ElementBending/Objects/EarthWall/EarthWall.tscn")

# variables
var undeployed_wall: Node2D = null


func init(parent: Node2D) -> void:
	base_init(parent)


func create_earth_wall(position: Position2D, parent_node: Node2D) -> Node2D:
	if undeployed_wall:
		return null
	var earth_wall = EarthWallScene.instance()
	parent_node.add_child(earth_wall)
	earth_wall.global_position = position.global_position
	earth_wall.global_rotation = position.global_rotation
	earth_wall.scale.y = 2
	undeployed_wall = earth_wall
	return earth_wall


func update_earth_wall_position(position: Position2D):
	undeployed_wall.global_position = position.global_position
	undeployed_wall.global_rotation = position.global_rotation


func deploy_earth_wall(parent_node: Node2D):
	if not undeployed_wall: return
	if undeployed_wall.deploy():
		var current_position = undeployed_wall.global_position
		var current_rotation = undeployed_wall.global_rotation
		var current_parent = undeployed_wall.get_parent()
		current_parent.remove_child(undeployed_wall)
		parent_node.add_child(undeployed_wall)
		undeployed_wall.global_position = current_position
		undeployed_wall.global_rotation = current_rotation
	else:
		undeployed_wall.queue_free()
	undeployed_wall = null


func destroy_earth_wall():
	if not undeployed_wall: return
	undeployed_wall.queue_free()
	undeployed_wall = null
