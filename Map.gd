extends Node2D

export var camera_bounds = Rect2(Vector2.ZERO, Vector2(960, 540));

func _init():
	add_to_group(Groups.MAP)
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
