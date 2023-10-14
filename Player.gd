extends KinematicBody2D

signal selected_item_chaged(selected_item)

var target_position = Vector2(0,0);
var target_object;

var MAX_SPEED = 80;
var velocity = Vector2.ZERO;
var moving = false;

var inventory = [preload("res://items/rusted_key.tres")];
var selected_item = null;

onready var camera = $Camera2D;
onready var navigation_agent = $NavigationAgent2D;

func _init():
	add_to_group(Groups.PLAYER);

func _ready():
	ClickManager.connect("object_clicked", self, "_on_object_clicked");
	ClickManager.connect("map_clicked", self, "_on_map_clicked");
	
func set_camera_bounds(bounds: Rect2):
	camera.limit_left = bounds.position.x;
	camera.limit_top = bounds.position.y;
	camera.limit_right = bounds.end.x;
	camera.limit_bottom = bounds.end.y;
	
func get_inventory():
	return inventory;
	
func _on_map_clicked(position: Vector2):
	target_object = null;
	set_target_position(position)

func _on_object_clicked(object, position: Vector2):
	target_object = object;
	set_target_position(position);

func set_target_position(pos: Vector2):
	GameplayUi.hide_text()
	navigation_agent.set_target_location(pos);
	moving = true;
	
func _physics_process(delta):
	if(not moving):
		return;
	
	var move_direction = position.direction_to(navigation_agent.get_next_location());
	velocity = move_direction * MAX_SPEED;
	navigation_agent.set_velocity(velocity);
	
	if(navigation_agent.is_navigation_finished()):
		if(target_object):
			target_object._on_inspect();
			
		moving = false;
	else:
		velocity = move_and_slide(velocity);
	
	
