class_name Bending

var _initiated: bool = false
var _parent: Node2D = null


func base_init(parent: Node2D) -> void:
	_parent = parent
	_initiated = true

func not_initiated():
	return not _initiated

