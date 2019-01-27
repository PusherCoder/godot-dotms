extends Area2D

signal hit

export (int) var speed
var screensize

func _ready():
	screensize = get_viewport_rect().size
	#hide()

func _input(event):
	if event.is_action_pressed("ui_left"):
		position.y += 48
		position.x -= 83
	if event.is_action_pressed("ui_right"):
		position.y += 48
		position.x += 83
	if event.is_action_pressed("ui_down"):
		position.y += 96
	if event.is_action_pressed("ui_up"):
		position.y -= 96
	if event.is_action_pressed("ui_page_down"):
		position.y -= 48
		position.x -= 83
	if event.is_action_pressed("ui_page_up"):
		position.y -= 48
		position.x += 83
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

#func _process(delta):

func _on_Player_body_entered(body):
	#hide()
	#emit_signal("hit")
	$CollisionShape2D.disabled = true

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false