extends Node

var current_map: Node2D;
var player: KinematicBody2D;

func warp_to_map(scene, id):
	current_map.free();
	current_map = load(scene).instance();
	add_child(current_map);
	var position_node = current_map.find_node(id);
	player.global_position = position_node.global_position;
	player.set_camera_bounds(current_map.camera_bounds)

func _ready():
	var players = get_tree().get_nodes_in_group(Groups.PLAYER);
	
	if(len(players) == 0):
		player = load("res://player.tscn").instance()
		add_child(player);
		current_map = get_tree().get_nodes_in_group(Groups.MAP)[0]
		player.set_camera_bounds(current_map.camera_bounds)

func get_player():
	return player;
