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
	keyboard_input(event)
	mouse_input(event)
	
func keyboard_input(event):
	if event.is_action_pressed("ui_left"):
		move(1)
	if event.is_action_pressed("ui_right"):
		move(5)
	if event.is_action_pressed("ui_down"):
		move(0)
	if event.is_action_pressed("ui_up"):
		move(3)
	if event.is_action_pressed("ui_page_down"):
		move(2)
	if event.is_action_pressed("ui_page_up"):
		move(4)

func mouse_input(event):
	#some variables that define how the hex grid is mapped to the screen position
	var hex_size = 94
	
	if event is InputEventMouseButton:
		var mouse_position = event.position
		if event.pressed and event.button_index == BUTTON_LEFT:
			
			var relative_mouse_position = mouse_position - position
			var mouse_angle = atan2(relative_mouse_position.x, relative_mouse_position.y)
			
			if (is_inside_hex(mouse_position, Vector2(position.x, position.y+94), 50)):
				move(0)
			if (is_inside_hex(mouse_position, Vector2(position.x-82, position.y+47), 50)):
				move(1)
			if (is_inside_hex(mouse_position, Vector2(position.x-82, position.y-47), 50)):
				move(2)
			if (is_inside_hex(mouse_position, Vector2(position.x, position.y-94), 50)):
				move(3)
			if (is_inside_hex(mouse_position, Vector2(position.x+82, position.y-47), 50)):
				move(4)
			if (is_inside_hex(mouse_position, Vector2(position.x+82, position.y+47), 50)):
				move(5)

func is_inside_hex(point, hex_position, hex_size):
	var deg_to_rad = .0174533
	var right_point = Vector2(hex_size * cos(0 * deg_to_rad), hex_size * sin(0 * deg_to_rad))
	var lower_right_point = Vector2(hex_size * cos(60 * deg_to_rad), hex_size * sin(60 * deg_to_rad))
	var lower_left_point = Vector2(hex_size * cos(120 * deg_to_rad), hex_size * sin(120 * deg_to_rad))
	var left_point = Vector2(hex_size * cos(180 * deg_to_rad), hex_size * sin(180 * deg_to_rad))
	var upper_left_point = Vector2(hex_size * cos(240 * deg_to_rad), hex_size * sin(240 * deg_to_rad))
	var upper_right_point = Vector2(hex_size * cos(300 * deg_to_rad), hex_size * sin(300 * deg_to_rad))
	
	var line1_side = get_line_side(upper_left_point, upper_right_point, point - hex_position) <= 0
	var line2_side = get_line_side(upper_right_point, right_point, point - hex_position) <= 0
	var line3_side = get_line_side(right_point, lower_right_point, point - hex_position) <= 0
	var line4_side = get_line_side(lower_right_point, lower_left_point, point - hex_position) <= 0
	var line5_side = get_line_side(lower_left_point, left_point, point - hex_position) <= 0
	var line6_side = get_line_side(left_point, upper_left_point, point - hex_position) <= 0
	
	return line1_side and line2_side and line3_side and line4_side and line5_side and line6_side
	
func get_line_side(line_p1, line_p2, point):
	return ((point.x - line_p1.x) * (line_p2.y - line_p1.y)) - ((point.y - line_p1.y) * (line_p2.x - line_p1.x))

func move(direction):
	if ( direction == 0 ): # down
		position.y += 94
	elif ( direction == 1 ): # down, left
		position.x -= 82
		position.y += 47
	elif ( direction == 2 ): # up, left
		position.x -= 82
		position.y -= 47
	elif ( direction == 3 ): # up
		position.y -= 94
	elif ( direction == 4 ): # up, right
		position.x += 82
		position.y -= 47
	elif ( direction == 5 ): # down, right
		position.x += 82
		position.y += 47
		
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

func _on_Monster_in_combat():
	$WSprite.frame = 1
