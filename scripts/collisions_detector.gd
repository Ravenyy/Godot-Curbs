extends Node2D
signal touch

func _on_Area2D_body_entered(body):
#func _ready():
	emit_signal("touch")
