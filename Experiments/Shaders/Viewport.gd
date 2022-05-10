extends Viewport

export (NodePath) var player_path
export (Rect2) var world_extents

var player : KinematicBody
var last_second = 1.0

func _ready():
	player = get_node(player_path)
	$Sprite.show()
	if not player:
		set_process(false)
	get_texture().set_flags(Texture.FLAG_FILTER)
	print_debug(size)


func _process(_delta):
	var player_pos = Vector2(player.translation.x, player.translation.z)
	
	var brush_pos = (player_pos / world_extents.size) * size
	# $Sprite.position = brush_pos
	
	
	last_second += _delta
	if (last_second > 1.0):
		print_debug($Sprite.position)
		last_second = 0
	# $TextureRect.texture = get_texture()

