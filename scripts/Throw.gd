extends RigidBody2D

onready var visibility_notifier = get_node("VisibilityNotifier2D")
var dragging
var drag_start = Vector2()
signal touch

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


func _on_VisibilityNotifier2D_screen_exited():
	mode = MODE_STATIC
	set_position(Vector2(154, 377))


func _on_Ball_body_entered(body):
	emit_signal("touch")
	print("chuj")
