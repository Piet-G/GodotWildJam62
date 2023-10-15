extends ClickableElement

export var map_id = ""
export var position_id = ""

func _on_inspect():
	MapManager.call_deferred("warp_to_map", WarpManager.get_map_scene(map_id), position_id, true)
