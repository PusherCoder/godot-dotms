extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _input(event):
	if event.is_action_pressed("key_up"):
		position.y -= 100
		position.x -= 90
		get_node("AnimatedSprite").set_flip_h( true )
	elif event.is_action_pressed("key_down"):
		position.y += 100
		position.x += 90
		get_node("AnimatedSprite").set_flip_h( false )
	elif event.is_action_pressed("key_right"):
		position.x += 90
		get_node("AnimatedSprite").set_flip_h( false )
	elif event.is_action_pressed("key_left"):
		position.x -= 90
		get_node("AnimatedSprite").set_flip_h( true )

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass
