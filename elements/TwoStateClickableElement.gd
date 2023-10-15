extends ClickableElement

export var save_id = ""
export var conditional_on: Resource
export var initial_text = ""
export var use_text = ""
export var on_use_text = ""
export var after_text = ""

func _ready():
	call_deferred("update_visibility");
		
func _on_inspect():
	if(!MapManager.get_player().is_flag_set(save_id)):
		if(conditional_on):
			Ui.gameplay_ui.show_text(initial_text);
			yield(Ui.gameplay_ui, "text_finished_appearing")
			Ui.gameplay_ui.show_question(use_text);
			var result = yield(Ui.gameplay_ui, "choice_made");
			
			if(result):
				Ui.gameplay_ui.show_text(on_use_text)
				yield(Ui.gameplay_ui, "text_finished_appearing")
				MapManager.get_player().set_flag(save_id)
				update_visibility()
		else:
			Ui.gameplay_ui.show_text(initial_text)
			MapManager.get_player().set_flag(save_id)
			update_visibility()
	else:
		Ui.gameplay_ui.show_text(after_text);

func update_visibility():
	if(MapManager.get_player().is_flag_set(save_id)):
		$State1.visible = false;
		$State2.visible = true;
	else:
		$State1.visible = true;
		$State2.visible = false;
