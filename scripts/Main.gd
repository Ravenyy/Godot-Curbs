extends Node2D

var points = 0

func reset_ball_position(ball = $Ball):
	ball.set("mode", 1)
	ball.set("left_curb_touch", false)
	ball.set("right_curb_touch", false)
	ball.set("asphalt_touch", false)
	ball.set("clicked", false)
	ball.set_position(Vector2(154, 377))
	

func draw_score_dots(p):
	match(p):
		1: 
			get_node("Score/PointFull1").show()
		2:
			get_node("Score/PointFull2").show()
		3:
			get_node("Score/PointFull3").show()
		0:
			get_node("Score/PointFull1").hide()
			get_node("Score/PointFull2").hide()
			get_node("Score/PointFull3").hide()


func _on_Ball_point_scored():
	points += 1
	print("points = ", points)
	if points <= 3:
		draw_score_dots(points)
	else:
		pass
	yield(get_tree().create_timer(1.5), "timeout")
	reset_ball_position()


func _on_Ball_points_lost():
	points = 0
	print("points = ", points)
	draw_score_dots(points)
	yield(get_tree().create_timer(1.5), "timeout")
	reset_ball_position()
	get_node("Score/PointFull1").hide()


func _on_Ball_ball_went_offscreen():
	points = 0
	print("points = ", points)
	draw_score_dots(points)
	reset_ball_position()
