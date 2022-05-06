extends Viewport

export (NodePath) var player_path
export (Rect2) var world_extents

var player : KinematicBody

func _ready():
	player = get_node(player_path)
	if not player:
		set_process(false)
	get_texture().set_flags(Texture.FLAG_FILTER)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var half_world = world_extents.size / 2
	var player_pos = Vector2(player.translation.x, player.translation.z)

	player_pos += half_world
	var brush_pos = player_pos / world_extents.size
	$Sprite.position = brush_pos * size

	$TextureRect.texture = get_texture()
