extends Control

onready var elements = $Elements
export var not_selected = Color.gray

func _ready():
	deselect_all()

func select_element(index: int):
	deselect_all()
	elements.get_child(
		index % elements.get_child_count()
	).modulate = Color.white

func deselect_all():
	for element in elements.get_children():
		element.modulate = not_selected
