class_name GameplayUI
extends CanvasLayer


onready var text_box = $TextBox;
onready var animation_player = $AnimationPlayer;
onready var selected_item_texture = get_node("%SelectedItemTexture")

var text_to_show = "";
var text_visible = false;
var inventory_open = true;

func _ready():
	MapManager.get_player().connect("selected_item_chaged", self, "_on_selected_item_changed")

func _on_selected_item_changed(item: Item):
	if(item):
		selected_item_texture.visible = true;
		selected_item_texture.texture = item.image;
	else:
		selected_item_texture.visible = false;

func show_text(text: String):
	print("Showing text")
	print_debug(text);
	text_to_show = text;
	text_visible = true
	text_box.clear_text();
	animation_player.play("text_appear");
	text_box.show_text(text_to_show);

func hide_text():
	if(text_visible):
		animation_player.play("text_disappear");
		text_visible = false;

func _on_Inventory_item_selected(item):
	selected_item_texture.texture = item.image;
	toggle_inventory_open()
	
func toggle_inventory_open():
	if(!inventory_open):
		animation_player.play("inventor_slide_in");
	else:
		animation_player.play("inventor_slide_out");
	inventory_open = !inventory_open;

func _on_Inventory_open_toggled():
	toggle_inventory_open()
