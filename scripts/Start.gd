extends Node2D

func _ready():
	randomize()
	Levels.levels.shuffle()
	print(Levels.levels)
	get_tree().change_scene("res://src/Main.tscn")

