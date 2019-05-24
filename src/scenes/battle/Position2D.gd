extends Position2D

export(float) var SPEED = 200.0

enum STATES { IDLE, FOLLOW }
var _state = null

var path = []
var target_point_world = Vector2()
var target_position = Vector2()
var hover_target_position = Vector2()

var velocity = Vector2()
var delay = 14

func _ready():
	_change_state(STATES.IDLE)


func _change_state(new_state):
	if new_state == STATES.FOLLOW:
		path = get_parent().get_node('floor')._get_path(position, target_position)
		if len(path) > 7:
			path = get_parent().get_node('floor')._get_path(position, position)
		if not path or len(path) == 1:
			_change_state(STATES.IDLE)
			return
		# The index 0 is the starting cell
		# we don't want the character to move back to it in this example
		target_point_world = path[1]
	_state = new_state


func _process(_delta):
	if not _state == STATES.FOLLOW:
		if hover_target_position != target_position:
			target_position = hover_target_position
			path = get_parent().get_node('floor')._get_path(position, target_position)
			if len(path) > 7:
				path = get_parent().get_node('floor')._get_path(position, position)
		return
	delay -= 1
	if delay > 0:
		return
	delay = 14
	var arrived_to_next_point = move_to(target_point_world)
	if arrived_to_next_point:
		path.remove(0)
		if len(path) == 0:
			_change_state(STATES.IDLE)
			return
		target_point_world = path[0]


func move_to(world_position):
	$Sprite.set_flip_h( position.x > world_position.x )
	position = world_position
	#rotation = velocity.angle()
	return true


func _input(event):
	if event.is_action_pressed('mouse_click'):
		if Input.is_key_pressed(KEY_SHIFT):
			global_position = get_global_mouse_position()
		else:
			target_position = get_global_mouse_position()
		_change_state(STATES.FOLLOW)
	elif event is InputEventMouseMotion:
		hover_target_position = get_global_mouse_position()
