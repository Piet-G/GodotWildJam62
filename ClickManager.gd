extends Node2D

signal object_clicked(object, click_position);
signal map_clicked(click_position);

func _unhandled_input(event):
	if(event.is_action_pressed("click")):
		emit_signal("map_clicked", get_global_mouse_position());
	
