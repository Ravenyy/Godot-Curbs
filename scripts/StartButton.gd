extends TextureButton

func _on_TextureButton_button_up():
	get_node("/root/Main/ModalStart").hide()
	get_node("/root/Main/Sounds/ButtonPress").play()
