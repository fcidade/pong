extends KinematicBody2D

export(NodePath) var target_ball
export (float) var speed = 2

var can_move = false

func _physics_process(delta):
	if not can_move: return
		
	var dir = get_node(target_ball).position - position
	dir = dir.normalized()
	dir.x = 0
	
	move_and_collide(dir * speed)


func _on_GUI_start_game():
	can_move = true
