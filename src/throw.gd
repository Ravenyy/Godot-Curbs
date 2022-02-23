extends RigidBody2D

var dragging
var drag_start = Vector2()

func _input(event):
	if event.is_action_pressed("click") and not dragging:
		dragging = true
		drag_start = get_global_mouse_position()
	if event.is_action_released("click") and dragging:
		mode = MODE_RIGID
		dragging = false
		var drag_end = get_global_mouse_position()
		var dir = drag_end - drag_start
		apply_impulse(Vector2(), dir * 1.4)
