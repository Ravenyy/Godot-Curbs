extends RigidBody2D

onready var visibility_notifier = get_node("VisibilityNotifier2D")
var dragging
var drag_start = Vector2()
var left_curb_touch = false
var right_curb_touch = false
var asphalt_touch = false
var clicked = false
signal point_scored
signal points_lost
signal ball_went_offscreen

func _input(event):
	if event.is_action_pressed("click") && not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
		
	if event.is_action_released("click") && clicked == false && dragging:
		clicked = true
		mode = MODE_RIGID
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_end - drag_start
		apply_impulse(Vector2(), dir * 1.4)


func _on_VisibilityNotifier2D_screen_exited():
	emit_signal("ball_went_offscreen")


func _on_Ball_body_shape_entered(_body_rid, body, _body_shape_index, _local_shape_index):
	match(body.name):
		"LeftCurbBody":
			if left_curb_touch == false && asphalt_touch == false:
				left_curb_touch = true
				print("Left curb touched")
				emit_signal("points_lost")

		"RightCurbBody":
			if right_curb_touch == false && left_curb_touch == false && asphalt_touch == false:
				right_curb_touch = true
				print("Right curb touched")

		"AsphaltBody":
			if asphalt_touch == false && left_curb_touch == false && right_curb_touch == true:
					asphalt_touch = true
					print("Asphalt touched")
					emit_signal("point_scored")
			elif asphalt_touch == false && left_curb_touch == false && right_curb_touch == false:
				asphalt_touch = true
				print("Asphalt touched before right curb")
				emit_signal("points_lost")

