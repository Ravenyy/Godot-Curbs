extends TextureButton

func _on_TextureButton_button_up():
	get_node("/root/Main/ModalStart").hide()
	get_node("/root/Main/Sounds/ButtonPress").play()
	yield(get_tree().create_timer(0.05), "timeout")
	get_node("/root/Main/Ball").clicked = false
