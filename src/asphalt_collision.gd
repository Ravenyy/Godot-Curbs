extends Node2D


onready var ball = get_tree().get_root().find_node("Ball", true, false)

func _on_Area2D_body_entered(body):
	ball.connect("touch", self, "handle_touch")
	
func handle_touch():
	print("Enemy has spotted me")
