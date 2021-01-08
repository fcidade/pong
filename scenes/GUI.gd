extends Control

signal start_game

var player_score := 0
var enemy_score := 0

func _process(delta):
	if Input.is_action_just_pressed("click"):
		$ClickToStart.visible = false
		emit_signal('start_game')
		player_score = 0
		enemy_score = 0
		update_scores()
		
func update_scores():
	$PlayerScore.text = str(player_score)
	$EnemyScore.text = str(enemy_score)
	

func _on_Ball_player_scored():
	player_score += 1
	update_scores()

func _on_Ball_enemy_scored():
	enemy_score += 1
	update_scores()
