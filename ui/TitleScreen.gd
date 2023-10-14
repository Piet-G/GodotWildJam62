extends Control

export(PackedScene) var initial_scene;

onready var default_selection = $Default;
onready var options_selection = $Options;

func _on_Start_pressed():
	MapManager.start_game(initial_scene, "WARP_A")
	self.queue_free()

func _on_Options_pressed():
	options_selection.visible = true;
	default_selection.visible = false;

func _on_Rate_pressed():
	pass # Replace with function body.


func _on_BackButton_pressed():
	options_selection.visible = false;
	default_selection.visible = true;


func _on_MasterVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value);

func _on_MusicVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value);

func _on_SfxVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value);
