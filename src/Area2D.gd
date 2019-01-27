extends Area2D

signal hit

export (int) var speed
var screensize

func _ready():
	screensize = get_viewport_rect().size
	#hide()

func _process(delta):
	if Input.is_action_pressed("ui_up"):
		position.x -= 6
		position.y -= 6
	if Input.is_action_pressed("ui_down"):
		position.x -= 6
		position.y += 6
	if Input.is_action_pressed("ui_left"):
		position.x -= 12
	if Input.is_action_pressed("ui_right"):
		position.x += 12
	if Input.is_action_pressed("ui_page_up"):
		position.x += 6
		position.y -= 6
	if Input.is_action_pressed("ui_page_down"):
		position.x += 6
		position.y += 6
	position.x = clamp(position.x, 0, screensize.x)
	position.y = clamp(position.y, 0, screensize.y)

func _on_Player_body_entered(body):
	#hide()
	#emit_signal("hit")
	$CollisionShape2D.disabled = true

func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false