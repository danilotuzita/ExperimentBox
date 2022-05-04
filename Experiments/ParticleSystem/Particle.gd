extends Node2D

export var width = 1
export var height = 1

onready var colorRect = $ColorRect
onready var area2d = $ColorRect/Area2D
onready var collision = $ColorRect/Area2D/CollisionShape2D


func _ready():
	colorRect.color = Color.white
	colorRect.rect_size = Vector2(width, height)
	area2d.size = Vector2(width, height) 

