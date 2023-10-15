extends Panel

signal chosen(result)

func _on_YesButton_pressed():
	emit_signal("chosen", true)


func _on_NoButton_pressed():
	emit_signal("chosen", false)
