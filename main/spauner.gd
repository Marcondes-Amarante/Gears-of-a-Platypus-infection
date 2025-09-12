extends Node2D

var Bat = preload("res://bat/bat.tscn")

func _process(delta: float):
	var n = randi_range(0, 1000) 
	if n < 3:
		var bullet_instance = Bat.instantiate()
		get_tree().root.add_child(bullet_instance)
