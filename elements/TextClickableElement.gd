extends "res://ClickableElement.gd"

export var text = ""

func _on_inspect():
	Ui.gameplay_ui.show_text(text);
