extends Area2D

var movement

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _input(event):
	if event.is_action_pressed("key_up"):
		get_node("RayCast2D").set_cast_to( Vector2( -90, -100 ) )
		movement = 1
	elif event.is_action_pressed("key_down"):
		get_node("RayCast2D").set_cast_to( Vector2( 90, 100 ) )
		movement = 2
	elif event.is_action_pressed("key_right"):
		get_node("RayCast2D").set_cast_to( Vector2( 90, 0 ) )
		movement = 3
	elif event.is_action_pressed("key_left"):
		get_node("RayCast2D").set_cast_to( Vector2( -90, 0 ) )
		movement = 4

func _process(delta):
	if movement == 1:
		movement = 0
		if get_node("RayCast2D").is_colliding() == false:
			position.y -= 100
			position.x -= 90
			get_node("AnimatedSprite").set_flip_h( true )
	elif movement == 2:
		movement = 0
		if get_node("RayCast2D").is_colliding() == false:
			position.y += 100
			position.x += 90
			get_node("AnimatedSprite").set_flip_h( false )
	elif movement == 3:
		movement = 0
		if get_node("RayCast2D").is_colliding() == false:
			position.x += 90
			get_node("AnimatedSprite").set_flip_h( false )
	elif movement == 4:
		movement = 0
		if get_node("RayCast2D").is_colliding() == false:
			position.x -= 90
			get_node("AnimatedSprite").set_flip_h( true )
