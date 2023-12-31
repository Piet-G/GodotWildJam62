extends Node2D

var current_map: Node2D;
var player: KinematicBody2D;

func _ready():
	randomize()

func warp_to_map(scene, id, animate_fade):
	if(animate_fade):
		BlackFader.fade_out(1);
		yield(BlackFader, "faded_out")
		
	if(current_map):
		current_map.free();
	current_map = scene.instance();
	add_child(current_map);
	var position_node = current_map.find_node(id);
	player.global_position = position_node.global_position;
	player.set_camera_bounds(current_map.camera_bounds)
	player.set_light_enabled(current_map.light_enabled)
	if(animate_fade):
		BlackFader.fade_in(1);
	
func initialise_player():
	player = load("res://player.tscn").instance()
	add_child(player);
	
func attempt_initialise_debug_player(map):
	if(not player):
		current_map = map;
		initialise_player();
		Ui.open_gameplay_ui()
		var position_node = current_map.find_node("WARP_A");
		player.global_position = position_node.global_position;
		player.set_camera_bounds(current_map.camera_bounds)
		print("Added debug player")
	
func start_game(initial_scene, position_id):
	initialise_player()
	Ui.open_gameplay_ui()
	warp_to_map(initial_scene, position_id, false)
	$AudioStreamPlayer2D.play()
	yield($AudioStreamPlayer2D, "finished")
	BlackFader.fade_in(1.5)
	
func restart_game():
	pass
	
func get_player():
	return player;


