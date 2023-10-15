extends Area2D

export var cutscene : PackedScene

func _on_CutsceneTrigger_body_entered(body):
	CutsceneManager.play_cutscene(cutscene)
	yield(CutsceneManager, "cutscene_completed")
	queue_free()

