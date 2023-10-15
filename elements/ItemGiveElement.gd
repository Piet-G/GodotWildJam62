extends ClickableElement

export(Resource) var item;
export var item_get_text = "";
export var empty_text = ""

var collected_item = false;

func _on_inspect():
	if(not collected_item):
		MapManager.get_player().lock_movement();
		Ui.gameplay_ui.show_text(item_get_text);
		yield(Ui.gameplay_ui, "text_finished_appearing")
		MapManager.get_player().add_item_to_inventory(item)
		MapManager.get_player().unlock_movement();
		
		collected_item = true
	else:
		Ui.gameplay_ui.show_text(empty_text)

