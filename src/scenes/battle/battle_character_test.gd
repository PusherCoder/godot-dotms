extends Area2D

onready var movement_ghost = preload("res://scenes/battle/movement_ghost.tscn")

const X_DISP = 45
const Y_DISP = 50
const MAX_DISP = 7

var movement_ready = false
var movement_array = [ Vector2( 0, 0 ) ]
var movement_array_position = 0

func reset_movement():
	for i in $ghost_zone.get_children():
		i.queue_free()
	movement_array = [ Vector2( 0, 0 ) ]
	movement_array_position = 0
	movement_ready = false
	$check_up.set_position( Vector2( 0, 0 ) )
	$check_left.set_position( Vector2( 0, 0 ) )
	$check_right.set_position( Vector2( 0, 0 ) )
	$check_down.set_position( Vector2( 0, 0 ) )

func _ready():
	pass

func _input(event):
	var somevector = Vector2(0,0)
	if movement_ready == true:
		if event.is_action_pressed("key_up") and movement_array.has( Vector2( 0, -Y_DISP ) ):
			position.y -= Y_DISP
			$AnimatedSprite.set_flip_h( true )
			reset_movement()
		elif event.is_action_pressed("key_down") and movement_array.has( Vector2( 0, Y_DISP ) ):
			position.y += Y_DISP
			$AnimatedSprite.set_flip_h( false )
			reset_movement()
		elif event.is_action_pressed("key_right") and movement_array.has( Vector2( X_DISP, 0 ) ):
			position.x += X_DISP
			$AnimatedSprite.set_flip_h( false )
			reset_movement()
		elif event.is_action_pressed("key_left") and movement_array.has( Vector2( -X_DISP, 0 ) ):
			position.x -= X_DISP
			$AnimatedSprite.set_flip_h( true )
			reset_movement()
	if event.is_action_pressed("mouse_click"):
		somevector = $nav.get_closest_point( event.position )
		print( somevector )

func _process(delta):
	if movement_array_position < movement_array.size():
		#print( "Processing " + var2str(movement_array[movement_array_position]) )
		var ghost = movement_ghost.instance()
		ghost.set_position( $check_up.position )
		$ghost_zone.add_child(ghost)
		if abs( $check_up.position.x / X_DISP ) + abs( $check_up.position.y / Y_DISP ) + 1 < MAX_DISP:
			if ( $check_up.is_colliding() == false ) and !movement_array.has( Vector2( $check_up.position.x, $check_up.position.y - Y_DISP ) ):
				movement_array.append( Vector2( $check_up.position.x, $check_up.position.y - Y_DISP ) )
			if ( $check_left.is_colliding() == false ) and !movement_array.has( Vector2( $check_left.position.x - X_DISP, $check_left.position.y ) ):
				movement_array.append( Vector2( $check_left.position.x - X_DISP, $check_left.position.y ) )
			if ( $check_right.is_colliding() == false ) and !movement_array.has( Vector2( $check_right.position.x + X_DISP, $check_right.position.y ) ):
				movement_array.append( Vector2( $check_right.position.x + X_DISP, $check_right.position.y ) )
			if ( $check_down.is_colliding() == false ) and !movement_array.has( Vector2( $check_down.position.x, $check_down.position.y + Y_DISP ) ):
				movement_array.append( Vector2( $check_down.position.x, $check_down.position.y + Y_DISP ) )
		movement_array_position += 1
		if movement_array_position == movement_array.size():
			movement_ready = true
		else:
			$check_up.set_position( movement_array[movement_array_position] )
			$check_left.set_position( movement_array[movement_array_position] )
			$check_right.set_position( movement_array[movement_array_position] )
			$check_down.set_position( movement_array[movement_array_position] )
