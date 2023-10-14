extends "res://ClickableElement.gd"

export var text = ""

func _on_inspect():
	GameplayUi.show_text(text);
