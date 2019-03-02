extends Area2D

signal hit

export (int) var speed
var screensize
var opacity
var blink_direction

func _ready():
	opacity = 1.0
	blink_direction = 0
	screensize = get_viewport_rect().size
	#hide()

func _input(event):
	if event.is_action_pressed("ui_left"):
		position.x -= 82
		position.y += 47
	if event.is_action_pressed("ui_right"):
		position.x += 82
		position.y += 47
	if event.is_action_pressed("ui_down"):
		position.y += 94
	if event.is_action_pressed("ui_up"):
		position.y -= 94
	if event.is_action_pressed("ui_page_down"):
		position.x -= 82
		position.y -= 47
	if event.is_action_pressed("ui_page_up"):
		position.x += 82
		position.y -= 47
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

func _process(delta):
	if( opacity < blink_direction ):
		opacity += 0.01
	if( opacity > blink_direction ):
		opacity -= 0.01
	if( opacity < 0.1 ):
		blink_direction = 1
	if( opacity > 0.9 ):
		blink_direction = 0
	$QSprite.modulate = Color(1,1,1,opacity)
	$WSprite.modulate = Color(1,1,1,opacity)
	$ESprite.modulate = Color(1,1,1,opacity)
	$ASprite.modulate = Color(1,1,1,opacity)
	$SSprite.modulate = Color(1,1,1,opacity)
	$DSprite.modulate = Color(1,1,1,opacity)

func _on_Player_body_entered(body):
	#hide()
	#emit_signal("hit")
	$CollisionShape2D.disabled = true

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false