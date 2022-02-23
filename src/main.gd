extends Node2D

onready var ball = $Ball

func _ready():
	pass
	

func _on_Area2D_body_entered(ball):
	print("cokolwiek")
