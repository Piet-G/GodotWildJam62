extends Area2D

export var target_id = "WARP_A"
export var map_id: String;

func _on_WarpPoint_body_entered(body):
	MapManager.call_deferred("warp_to_map", WarpManager.get_map_scene(map_id), target_id)

