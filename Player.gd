extends KinematicBody2D

signal selected_item_chaged(selected_item)

var target_position = Vector2(0,0);
var target_object;

var MAX_SPEED = 80;
var velocity = Vector2.ZERO;
var last_direction = Vector2.DOWN;
var moving = false;
var current_animation;

var inventory = [preload("res://items/rusted_key.tres")];
var selected_item = null;

onready var camera = $Camera2D;
onready var navigation_agent = $NavigationAgent2D;
onready var sprite = $AnimatedSprite;

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
	Ui.gameplay_ui.hide_text()
	navigation_agent.set_target_location(pos);
	moving = true;
	target_position = pos;
	
func play_or_continue_animation():
	var angle = last_direction.angle() + PI;
	var direction
	var state
	var flipped
	
	if(moving):
		state = "walk"
	else:
		state = "idle"
		
	if(angle >= 2 * PI - PI / 8 or angle < 0 + PI / 8):
		direction = "side"
		flipped = true
	elif(angle >= PI / 4 - PI / 8 and angle < PI / 4 + PI / 8):
		direction = "side_up"
		flipped = true
	elif(angle >= PI / 2 - PI / 8 and angle < PI / 2 + PI / 8):
		direction = "up"
		flipped = false
	elif(angle >= PI * 3/4 - PI / 8 and angle < PI * 3/4 + PI / 8):
		direction = "side_up"
		flipped = false
	elif(angle >= PI - PI / 8 and angle < PI + PI / 8):
		direction = "side"
		flipped = false
	elif(angle >= PI * 5/4 - PI / 8 and angle < PI * 5/4 + PI / 8):
		direction = "side_down"
		flipped = false
	elif(angle >= PI * 6/4 - PI / 8 and angle < PI * 6/4 + PI / 8):
		direction = "down";
		flipped = true
	elif(angle >= PI * 7/4 - PI / 8 and angle < PI * 7/4 + PI / 8):
		direction = "side_down"
		flipped = true;
	
	sprite.flip_h = flipped;
	sprite.animation = state + "_" + direction
	
	
func _physics_process(delta):
	if(not moving):
		play_or_continue_animation();
		return;
	
	var move_direction = position.direction_to(navigation_agent.get_next_location());
	last_direction = move_direction;
	play_or_continue_animation();
	velocity = move_direction * MAX_SPEED;
	navigation_agent.set_velocity(velocity);

	if(navigation_agent.is_navigation_finished()):
		if(target_object):
			target_object._on_inspect();
		
		last_direction = position.direction_to(target_position)
		moving = false;
	else:
		velocity = move_and_slide(velocity);
	
	
