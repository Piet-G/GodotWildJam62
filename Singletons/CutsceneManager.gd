extends CanvasLayer

signal cutscene_completed();

func play_cutscene(scene):
	BlackFader.fade_out(0.5)
	yield(BlackFader, "faded_out");
	var cutscene = scene.instance();
	add_child(cutscene)
	BlackFader.fade_in(1.5)
	yield(cutscene, "completed");
	print("Cutscene completed")
	BlackFader.fade_out(1.5)
	yield(BlackFader, "faded_out");
	cutscene.queue_free();
	BlackFader.fade_in(0.5);
	emit_signal("cutscene_completed")

