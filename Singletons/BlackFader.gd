extends CanvasLayer

onready var tween = $Tween
onready var texture = $Texture

signal faded_in()
signal faded_out()

func fade_out(time):
	tween.interpolate_property(texture, "color", Color(0,0,0,0), Color.black, time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	emit_signal("faded_out")

func fade_in(time):
	tween.interpolate_property(texture, "color", Color.black, Color(0,0,0,0), time, Tween.TRANS_LINEAR, Tween.EASE_OUT)
	tween.start()
	yield(tween, "tween_all_completed")
	emit_signal("faded_in")
	
