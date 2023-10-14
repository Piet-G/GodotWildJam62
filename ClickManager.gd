extends Node

signal object_clicked(object, click_position);
signal map_clicked(click_position);

func _unhandled_input(event):
	if(event.is_action_pressed("click")):
		emit_signal("map_clicked", get_viewport().get_mouse_position());
