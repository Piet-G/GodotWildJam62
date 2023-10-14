extends Area2D

export var target_id = "WARP_A"
export(String, FILE, "*.tscn") var scene;

func _on_WarpPoint_body_entered(body):
	MapManager.call_deferred("warp_to_map", scene, target_id)

