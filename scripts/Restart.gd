extends TextureButton

func _on_Restart_button_up():
	get_node("/root/Main/Sounds/ButtonPress")
	get_tree().change_scene("res://src/ShuffleLevels.tscn")
	get_node("/root/Main/Ball").swipe_start = 0
	yield(get_tree().create_timer(0.05), "timeout")
