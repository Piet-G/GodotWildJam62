extends Panel

signal text_appeared()
signal text_finished_appearing(complete)

var CHARACTERS_PER_SECOND = 70;

onready var label = $Label;
onready var tween = $Tween;

func _ready():
	tween.connect("tween_completed", self, "_on_tween_completed")
func _on_tween_completed(object, key):
	_finish_text(true)

func show_text(text: String):
	print("Showing text")
	tween.remove_all()
	label.visible_characters = 0;
	label.text = text;
	tween.interpolate_method(self, "set_visible_characters", 0, len(text) - text.count(" "), float(len(text)) / CHARACTERS_PER_SECOND)
	tween.start()
	$AudioStreamPlayer.play()

func set_visible_characters(chars):
	label.visible_characters = stepify(chars, 1);

func clear_text():
	label.visible_characters = 0;
	
func _finish_text(complete):
	emit_signal("text_appeared")
	emit_signal("text_finished_appearing", complete)
	$AudioStreamPlayer.stop()
	
func attempt_interrupt():
	if(tween.is_active()):
		tween.remove_all()
		_finish_text(false)
