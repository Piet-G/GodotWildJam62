extends Node

func get_map_scene(map_id):
	match(map_id):
		"DemoMap": 
			return load("res://maps/DemoMap/DemoMap.tscn")
		"WarpTest1":
			return load("res://maps/WarpTest1.tscn")
		"WarpTest2":
			return load("res://maps/WarpTest2.tscn")
