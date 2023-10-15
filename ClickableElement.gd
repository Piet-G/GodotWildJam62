class_name ClickableElement
extends StaticBody2D

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
		print(name, " clicked!")
		ClickManager.emit_signal("object_clicked", self, get_viewport().get_mouse_position());

func _on_inspect():
	print("Interacted with ", name)
	Ui.gameplay_ui.show_text("A nice wooden table");
