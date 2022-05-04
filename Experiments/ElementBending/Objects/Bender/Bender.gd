extends Pawn

onready var collision = $Collision
onready var hud = get_parent().find_node("HUD")

var element: int = 0
enum ELEMENT {
	FIGHT,
	WATER,
	EARTH,
	FIRE,
	WIND
}
var fight_bending = FightBending.new()
var water_bending = WaterBending.new()
var earth_bending = EarthBending.new()
var fire_bending = FireBending.new()
var wind_bending = WindBending.new()


func _ready():
	hud.call_deferred("select_element", element)
	fight_bending.init(self, 2, 2, 1)
	water_bending.init(self)
	earth_bending.init(self)
	fire_bending.init(self)
	wind_bending.init(self)
	walk_speed = 500


func _physics_process(delta: float):
	match element:
		ELEMENT.FIGHT:
			if Input.is_action_just_pressed("action_attack1"):
				fight_bending.create_punch($Collision/RightArmClose, self)
			if Input.is_action_just_pressed("action_attack2"):
				fight_bending.create_punch($Collision/LeftArmClose, self, false)
		ELEMENT.WATER:
			if Input.is_action_just_pressed("action_attack1"):
				water_bending.create_water_punch($Collision/RightArm, get_parent())
			if Input.is_action_just_pressed("action_attack2"):
				water_bending.create_water_punch($Collision/LeftArm, get_parent())
		ELEMENT.EARTH:
			for action in ["action_attack1", "action_attack2"]:
				if Input.is_action_just_pressed(action):
					if earth_bending.undeployed_wall:
						earth_bending.update_earth_wall_position($Collision/FrontFar)
					else:
						earth_bending.create_earth_wall($Collision/FrontClose, collision)
				if Input.is_action_just_released(action):
					earth_bending.deploy_earth_wall(get_parent())
		ELEMENT.FIRE:
			if Input.is_action_just_pressed("action_attack1"):
				fire_bending.create_fireball($Collision/RightArm, get_parent())
			if Input.is_action_just_pressed("action_attack2"):
				fire_bending.create_fireball($Collision/LeftArm, get_parent())
		ELEMENT.WIND:
			if Input.is_action_just_pressed("action_attack1"):
				wind_bending.create_gale($Collision/FrontClose, false, collision)
			if Input.is_action_just_pressed("action_attack2"):
				wind_bending.create_gale($Collision/FrontFar, true, collision)
			for action in ["action_attack1", "action_attack2"]:
				if Input.is_action_just_released(action):
					wind_bending.deploy_gale(get_parent())
	
	for i in range(ELEMENT.size()):
		if Input.is_action_just_pressed("action_change_to_element" + String(i)):
			element = i
			hud.select_element(element)
			earth_bending.destroy_earth_wall()
	
	var mouse_pos = get_viewport().get_mouse_position()
	collision.rotation = mouse_pos.angle_to_point(global_position)
	
	read_movement()
	process_movement(delta)
	$Velocity.points[1] = final_velocity / 10
	$Movement.points[1] = movement_force / 10
	$Inertia.points[1] = inertia_force / 10


func read_movement():
	walk(
		Vector2(
			Input.get_action_strength("action_right") - Input.get_action_strength("action_left"),
			Input.get_action_strength("action_down") - Input.get_action_strength("action_up")
		)
	)
