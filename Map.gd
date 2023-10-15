extends Node2D

export var camera_bounds = Rect2(Vector2.ZERO, Vector2(960, 540));
export var light_enabled = false;

func _init():
	add_to_group(Groups.MAP)

func _ready():
	MapManager.attempt_initialise_debug_player(self)


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
