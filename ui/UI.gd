extends CanvasLayer

var gameplay_ui: GameplayUI;

func open_gameplay_ui():
	gameplay_ui = preload("res://ui/GameplayUI.tscn").instance();
	add_child(gameplay_ui);
