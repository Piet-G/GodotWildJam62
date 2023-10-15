extends Node

func get_map_scene(map_id):
	match(map_id):
		"DemoMap": 
			return load("res://maps/DemoMap/DemoMap.tscn")
		"WarpTest1":
			return load("res://maps/WarpTest1.tscn")
		"WarpTest2":
			return load("res://maps/WarpTest2.tscn")
		"MainSquare":
			return load("res://maps/TownSquare/TownSquareMap.tscn")
		"PlayerHouse":
			return load("res://maps/Player_house/PlayerHouse.tscn")
		"GrannyHouse":
			return load("res://maps/Granny_house/GrannyHouse.tscn")
		"GrannyBedroom":
			return load("res://maps/Granny_house/GrannyBedroom.tscn")
