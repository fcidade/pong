extends KinematicBody2D

var speed := 1.0
var bounce_accel := 0.1
var dir := Vector2.ZERO

signal player_scored
signal enemy_scored

func spawn():
	var window_size = get_viewport_rect().size
	position = window_size / 2
	dir = Vector2.RIGHT.rotated(rand_range(-PI, PI))
	speed = 1.0

func _ready():
	randomize()
	
func _physics_process(delta):
	var radius = $Shape.shape.radius
	var window_size = get_viewport_rect().size
	
	var collision = move_and_collide(dir * speed)
	if collision:
		paddle_collision(collision)
	check_vertical_out_of_bounds(radius, window_size)
	check_horizontal_out_of_bounds(radius, window_size)

func paddle_collision(collision):
	var paddle = collision.collider
	dir = position - paddle.position
	dir = dir.normalized()
	speed += bounce_accel

func check_vertical_out_of_bounds(radius, window_size):
	if position.y - radius < 0 \
	or position.y + radius > window_size.y:
		speed += bounce_accel
		dir.y *= -1
		
func check_horizontal_out_of_bounds(radius, window_size):
	if position.x - radius < 0 \
	or position.x + radius > window_size.x:
		emit_score()
		spawn()
		
func emit_score():
	var window_size = get_viewport_rect().size
	if position.x < (window_size.x / 2):
		emit_signal('enemy_scored')
	else:
		emit_signal('player_scored')


func _on_GUI_start_game():
	spawn()
