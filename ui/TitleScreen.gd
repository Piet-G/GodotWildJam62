extends Control

export(PackedScene) var initial_scene;

onready var default_selection = $Default;
onready var options_selection = $Options;

var buttons_disabled = false;

func _on_Start_pressed():
	if(buttons_disabled):
		return
		
	BlackFader.fade_out(1)
	buttons_disabled = true
	yield(BlackFader, "faded_out")
	
	yield(get_tree().create_timer(3), "timeout");
	
	MapManager.start_game(initial_scene, "WARP_A")
	self.queue_free()

func _on_Options_pressed():
	if(buttons_disabled):
		return
	
	options_selection.visible = true;
	default_selection.visible = false;

func _on_Rate_pressed():
	if(buttons_disabled):
		return
		
	pass # Replace with function body.


func _on_BackButton_pressed():
	if(buttons_disabled):
		return

	options_selection.visible = false;
	default_selection.visible = true;


func _on_MasterVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), value);

func _on_MusicVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value);

func _on_SfxVolumeSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value);
