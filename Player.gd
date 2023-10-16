extends KinematicBody2D

signal selected_item_chaged(selected_item)
signal item_added(item)

var target_position = Vector2(0,0);
var target_object;

var MAX_SPEED = 100;
var velocity = Vector2.ZERO;
var last_direction = Vector2.DOWN;
var moving = false;
var current_animation;
var state_flags = {}

var inventory = [preload("res://items/rusted_key.tres"), preload("res://items/shovel.tres")];
var selected_item = null;
var movement_locked = false

onready var camera = $Camera2D;
onready var navigation_agent = $NavigationAgent2D;
onready var sprite = $AnimatedSprite;

func is_flag_set(flag):
	return state_flags.has(flag);
	
func set_flag(flag):
	state_flags[flag] = true;

func lock_movement():
	movement_locked = true;
	stop_movement()
	
func unlock_movement():
	movement_locked = false;

func add_item_to_inventory(item: Item):
	inventory.append(item);
	emit_signal("item_added", item)
	
func has_item(item: Item):
	return inventory.has(item);
	
func is_holding_item(item: Item):
	return selected_item == item;

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
	if(movement_locked):
		return
	target_object = null;
	set_target_position(position)

func _on_object_clicked(object, position: Vector2):
	if(movement_locked):
		return
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
		$FootstepsAudio.stream_paused = false
	else:
		$FootstepsAudio.stream_paused = true
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
	
func stop_movement():
	moving = false;

func set_light_enabled(enabled):
	$Light2D.enabled = enabled

func _physics_process(delta):
	if(not moving):
		play_or_continue_animation();
		return;
	
	#if(Input.is_action_pressed("click")):
	#	_on_map_clicked(get_global_mouse_position())
	
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
	
	
