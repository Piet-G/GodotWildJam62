class_name ClickableElement
extends StaticBody2D

export var exact_position = true

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_ClickableElement_input_event(viewport, event: InputEvent, shape_idx):	
	if(event.is_action_pressed("click")):		
		var target_position;
		
		if(exact_position):
			target_position = get_global_mouse_position();
		else:
			target_position = global_position;
		
		ClickManager.emit_signal("object_clicked", self, target_position);
		
	

func _on_inspect():
	print("Interacted with ", name)
	Ui.gameplay_ui.show_text("A nice wooden table");
