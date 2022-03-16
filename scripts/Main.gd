extends Node2D

var points = 0
var throws = 1
onready var levelCounter = get_node("LevelCounter")
var levelText = "[font=fonts/LuckiestGuy.tres] Level %d/6[/font]"

func _ready():
	set_level()


func set_level():
	if Levels.current > 0:
		get_node("Sounds/NextLevel").play()
		get_node("Background/" + Levels.levels[Levels.current - 1][0]).hide()
	get_node("Background/" + Levels.levels[Levels.current][0]).show()
	get_node("Left Curb").set_position(Vector2(Levels.levels[Levels.current][1], 522))
	get_node("Right Curb").set_position(Vector2(Levels.levels[Levels.current][2], 522))
	Levels.current += 1
	levelCounter.set_bbcode(levelText % Levels.current)


func _on_Ball_ball_went_offscreen():
	points = 0
	print("points = ", points)
	draw_score_dots(points)
	reset_ball_position()


func reset_ball_position(ball = $Ball):
	throws += 1
	ball.set("mode", 1)
	ball.set_position(Vector2(154, 377))
	yield(get_tree().create_timer(0.05), "timeout")
	set_ball_attributes()


func set_ball_attributes(ball = $Ball):
	ball.set("left_curb_touch", false)
	ball.set("right_curb_touch", false)
	ball.set("asphalt_touch", false)
	ball.set("clicked", false)
	ball.set("right_curb_continuous_touch", false)
	ball.set("right_curb_collisions", 0)


func draw_score_dots(p):
	match(p):
		1: 
			get_node("Score/PointFull1").show()
			get_node("Sounds/Point1").play()
		2:
			get_node("Score/PointFull2").show()
			get_node("Sounds/Point2").play()
		3:
			get_node("Score/PointFull3").show()
			get_node("Sounds/Point3").play()
		0:
			get_node("Score/PointFull1").hide()
			get_node("Score/PointFull2").hide()
			get_node("Score/PointFull3").hide()
			get_node("Sounds/Lose").play()


func _on_Ball_point_scored():
	points += 1
	print("points = ", points)
	if points < 3:
		draw_score_dots(points)
		yield(get_tree().create_timer(1.5), "timeout")
		reset_ball_position()
	elif points == 3 && Levels.current < 6:
		draw_score_dots(points)
		yield(get_tree().create_timer(1.5), "timeout")
		set_level()
		points = 0
		draw_score_dots(points)
		reset_ball_position()
	else:
		draw_score_dots(points)
		yield(get_tree().create_timer(1.5), "timeout")
		var throwsText = "[center][font=fonts/LuckiestGuy.tres]Congratulations!\n" \
					   + "You did it with\n%d\nthrows[/font][/center]"
		get_node("ModalEnd/Throws").set_bbcode(throwsText % throws)
		get_node("ModalEnd").show()
		get_node("Sounds/GameWin").play()


func _on_Ball_points_lost():
	points = 0
	print("points = ", points)
	draw_score_dots(points)
	yield(get_tree().create_timer(1.5), "timeout")
	reset_ball_position()
	get_node("Score/PointFull1").hide()

