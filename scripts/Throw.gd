extends RigidBody2D

onready var visibility_notifier = get_node("VisibilityNotifier2D")
var dragging
var drag_start = Vector2()
var left_curb_touch = false
var right_curb_touch = false
var asphalt_touch = false
var clicked = false
var right_curb_continuous_touch = false
var right_curb_collisions = 0
signal point_scored
signal points_lost
signal ball_went_offscreen

func _input(event):
	if event.is_action_pressed("click") && not dragging \
	&& not get_node("/root/Main/ModalStart").is_visible():
		dragging = true
		drag_start = get_global_mouse_position()
		
	if event.is_action_released("click") && clicked == false && dragging \
	&& not get_node("/root/Main/ModalStart").is_visible():
		clicked = true
		mode = MODE_RIGID
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_end - drag_start
		apply_impulse(Vector2(), dir * 1.4)

	if Input.is_key_pressed(KEY_K):
		emit_signal("point_scored")


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
				right_curb_collisions += 1
				print("Right curb touched")
			elif right_curb_touch == true && right_curb_collisions < 20 \
			&& right_curb_continuous_touch == false:
				print("right curb")
				right_curb_collisions += 1
			elif right_curb_touch == true && right_curb_collisions >= 20 \
			&& right_curb_continuous_touch == false:
				right_curb_continuous_touch = true
				emit_signal("points_lost")

		"AsphaltBody":
			if asphalt_touch == false && left_curb_touch == false && right_curb_touch == true:
					asphalt_touch = true
					print("Asphalt touched")
					emit_signal("point_scored")
			elif asphalt_touch == false && left_curb_touch == false && right_curb_touch == false:
				asphalt_touch = true
				print("Asphalt touched before right curb")
				emit_signal("points_lost")

