extends Area2D

const X_DISP = 90
const Y_DISP = 100
const MAX_DISP = 3

var movement_ready = false
var movement_array = [ Vector2( 0, 0 ) ]
var movement_array_position = 0

func reset_movement():
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
	if movement_ready == true:
		if event.is_action_pressed("key_up") and movement_array.has( Vector2( -X_DISP, -Y_DISP ) ):
			position.y -= Y_DISP
			position.x -= X_DISP
			$AnimatedSprite.set_flip_h( true )
			reset_movement()
		elif event.is_action_pressed("key_down") and movement_array.has( Vector2( X_DISP, Y_DISP ) ):
			position.y += Y_DISP
			position.x += X_DISP
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

func _process(delta):
	if movement_array_position < movement_array.size():
		if ( $check_up.is_colliding() == false ) and !movement_array.has( Vector2( $check_up.position.x - X_DISP, $check_up.position.y - Y_DISP ) ) and ( abs( $check_up.position.x / X_DISP ) + abs( $check_up.position.y / Y_DISP ) + 1 < MAX_DISP ):
			movement_array.append( Vector2( $check_up.position.x - X_DISP, $check_up.position.y - Y_DISP ) )
		if ( $check_left.is_colliding() == false ) and !movement_array.has( Vector2( $check_left.position.x - X_DISP, $check_left.position.y ) ) and ( abs( $check_left.position.x / X_DISP ) + abs( $check_left.position.y / Y_DISP ) + 1 < MAX_DISP ):
			movement_array.append( Vector2( $check_left.position.x - X_DISP, $check_left.position.y ) )
		if ( $check_right.is_colliding() == false ) and !movement_array.has( Vector2( $check_right.position.x + X_DISP, $check_right.position.y ) ) and ( abs( $check_right.position.x / X_DISP ) + abs( $check_right.position.y / Y_DISP ) + 1 < MAX_DISP ):
			movement_array.append( Vector2( $check_right.position.x + X_DISP, $check_right.position.y ) )
		if ( $check_down.is_colliding() == false ) and !movement_array.has( Vector2( $check_down.position.x + X_DISP, $check_down.position.y + Y_DISP ) ) and ( abs( $check_down.position.x / X_DISP ) + abs( $check_down.position.y / Y_DISP ) + 1 < MAX_DISP ):
			movement_array.append( Vector2( $check_down.position.x + X_DISP, $check_down.position.y + Y_DISP ) )
		movement_array_position += 1
		if movement_array_position == movement_array.size():
			movement_ready = true
		else:
			$check_up.set_position( movement_array[movement_array_position] )
			$check_left.set_position( movement_array[movement_array_position] )
			$check_right.set_position( movement_array[movement_array_position] )
			$check_down.set_position( movement_array[movement_array_position] )

