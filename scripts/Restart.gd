extends TextureButton

func _on_Restart_button_up():
	get_node("/root/Main/Sounds/ButtonPress")
	get_tree().change_scene("res://src/ShuffleLevels.tscn")

