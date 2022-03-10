extends Node2D

func _ready():
	randomize()
	Levels.levels.shuffle()
	print(Levels.levels)
	Levels.current = 0
	get_tree().change_scene("res://src/Main.tscn")

