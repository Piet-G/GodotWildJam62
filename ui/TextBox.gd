extends Panel

var CHARACTERS_PER_SECOND = 18;

onready var label = $Label;
onready var tween = $Tween;

func show_text(text: String):
	label.visible_characters = 0;
	label.text = text;
	tween.interpolate_property(label, "visible_characters", 0, len(text), len(text) / CHARACTERS_PER_SECOND, Tween.TRANS_LINEAR, Tween.EASE_IN_OUT)
	tween.start()
	
func clear_text():
	label.visible_characters = 0;
	tween.stop_all()
