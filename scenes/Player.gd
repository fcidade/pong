extends KinematicBody2D

var dir = Vector2.ZERO
export (float) var speed = 1.5

var can_move = false

func _physics_process(delta):
	if not can_move: return
	
	var y_dist = get_global_mouse_position().y - position.y
	if abs(y_dist) > 5:
		dir.y = y_dist
		dir = dir.normalized()
		
		move_and_collide(dir * speed)


func _on_GUI_start_game():
	can_move = true
