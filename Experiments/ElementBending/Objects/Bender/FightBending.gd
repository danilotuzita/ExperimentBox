extends Bending
class_name FightBending
var CooldownHandlerRef = load("res://Experiments/ElementBending/Objects/Utils/CooldownHandler.tscn")
var Punch = load("res://Experiments/ElementBending/Objects/Punch/Punch.tscn")


var right_cooldown: CooldownHandler
var left_cooldown: CooldownHandler


func init(parent: Node2D, left_punches: int = 2, right_punches: int = 2, punch_cooldown: float = .5) -> void:
	base_init(parent)
	right_cooldown = CooldownHandlerRef.instance()
	right_cooldown.init(right_punches, punch_cooldown)
	parent.add_child(right_cooldown)
	left_cooldown = CooldownHandlerRef.instance()
	left_cooldown.init(left_punches, punch_cooldown)
	parent.add_child(left_cooldown)
	

func create_punch(position: Position2D, parent_node: Node2D, right: bool = true) -> Node2D:
	var cooldown = (right_cooldown if right else left_cooldown).get_cooldown()
	if cooldown:
		var punch = Punch.instance()
		parent_node.add_child(punch)
		punch.setup(position, _parent)
		cooldown.start()
		return punch
	return null
