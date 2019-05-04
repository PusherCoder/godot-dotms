extends Area2D

onready var movement_ghost = preload("res://scenes/battle/movement_ghost.tscn")

const X_DISP = 45
const Y_DISP = 50
const MAX_DISP = 7

var movement_ready = false
var movement_array = [ Vector3( 0, 0, 0 ) ] #x = x position, y = y position, z number of moves need to get there
var movement_array_position = 0

func reset_movement():
	for i in $ghost_zone.get_children():
		i.queue_free()
	movement_array = [ Vector3( 0, 0, 0 ) ]
	movement_array_position = 0
	movement_ready = false
	$check_up.set_position( Vector2( 0, 0 ) )
	$check_left.set_position( Vector2( 0, 0 ) )
	$check_right.set_position( Vector2( 0, 0 ) )
	$check_down.set_position( Vector2( 0, 0 ) )

func _ready():
	pass

#Since the new movement array is a bunch of Vector3s, we need a way to test if a Vector2 is in the
#movement array. To do this, just compare the x and y of the Vector2 with the x and y of the Vector3.
func _movement_array_has(vec2):
	for position in movement_array:
		if position.x == vec2.x and position.y == vec2.y:
			return true
	
	return false
	
#We also want a way to get a Vector2 from the array
func _movement_array_get(index):
	return Vector2(movement_array[index].x, movement_array[index].y)

func _input(event):
	if movement_ready == true:
		if event.is_action_pressed("key_up") and _movement_array_has( Vector2( 0, -Y_DISP ) ):
			position.y -= Y_DISP
			$AnimatedSprite.set_flip_h( true )
			reset_movement()
		elif event.is_action_pressed("key_down") and _movement_array_has( Vector2( 0, Y_DISP ) ):
			position.y += Y_DISP
			$AnimatedSprite.set_flip_h( false )
			reset_movement()
		elif event.is_action_pressed("key_right") and _movement_array_has( Vector2( X_DISP, 0 ) ):
			position.x += X_DISP
			$AnimatedSprite.set_flip_h( false )
			reset_movement()
		elif event.is_action_pressed("key_left") and _movement_array_has( Vector2( -X_DISP, 0 ) ):
			position.x -= X_DISP
			$AnimatedSprite.set_flip_h( true )
			reset_movement()

func _process(delta):
	while movement_ready == false:
		print( "Processing " + var2str(movement_array[movement_array_position]) )
		
		#Create a new ghost for each position we can move to (except the one we're already at)
		if $check_up.position != Vector2(0, 0):
			var ghost = movement_ghost.instance() 
			ghost.set_position( $check_up.position )
			$ghost_zone.add_child(ghost)
		
		#Move the raycasts to the new position and force them to update.
		var current_position = _movement_array_get(movement_array_position);
		$check_up.set_position( current_position )
		$check_up.force_raycast_update()
		$check_left.set_position( current_position )
		$check_left.force_raycast_update()
		$check_right.set_position( current_position )
		$check_right.force_raycast_update()
		$check_down.set_position( current_position )
		$check_down.force_raycast_update()
		
		#We're using the z component of the elements in the movement array to store how many move
		#it takes to get to that position. 
		var distance_from_original_position = movement_array[movement_array_position].z
		
		#Check all four cardinal directions from where we just added a 'ghost'. If there are no 
		#obstructions, add it to the movement array.
		if distance_from_original_position + 1 < MAX_DISP:
			if ( $check_up.is_colliding() == false ) and !_movement_array_has( Vector2( $check_up.position.x, $check_up.position.y - Y_DISP ) ):
				movement_array.append( Vector3( $check_up.position.x, $check_up.position.y - Y_DISP, distance_from_original_position + 1 ) )
			if ( $check_left.is_colliding() == false ) and !_movement_array_has( Vector2( $check_left.position.x - X_DISP, $check_left.position.y ) ):
				movement_array.append( Vector3( $check_left.position.x - X_DISP, $check_left.position.y, distance_from_original_position + 1 ) )
			if ( $check_right.is_colliding() == false ) and !_movement_array_has( Vector2( $check_right.position.x + X_DISP, $check_right.position.y ) ):
				movement_array.append( Vector3( $check_right.position.x + X_DISP, $check_right.position.y, distance_from_original_position + 1 ) )
			if ( $check_down.is_colliding() == false ) and !_movement_array_has( Vector2( $check_down.position.x, $check_down.position.y + Y_DISP ) ):
				movement_array.append( Vector3( $check_down.position.x, $check_down.position.y + Y_DISP, distance_from_original_position + 1 ) )
		
		movement_array_position += 1
		
		if movement_array_position == movement_array.size():
			movement_ready = true
