class_name GameplayUI
extends CanvasLayer

signal text_appeared()
signal text_finished_appearing(fully_completed)
signal choice_made(chosen)

onready var text_box = $TextBox;
onready var animation_player = $AnimationPlayer;
onready var selected_item_texture = get_node("%SelectedItemTexture")
onready var inventory = $Inventory
onready var choice = $Choice

var text_visible = false;
var inventory_open = true;
var item_to_add;

func _ready():
	MapManager.get_player().connect("selected_item_chaged", self, "_on_selected_item_changed")
	MapManager.get_player().connect("item_added", self, "_on_item_added")
	text_box.connect("text_appeared", self, "_on_text_appeared")
	
func _on_text_appeared():
	emit_signal("text_appeared")
	
func _on_item_added(item):
	print("Item added")
	item_to_add = item;
	
	if(inventory_open):
		inventory.add_item(item)
		item_to_add = null
	else:
		open_inventory()

func _on_selected_item_changed(item: Item):
	if(item):
		selected_item_texture.visible = true;
		selected_item_texture.texture = item.image;
	else:
		selected_item_texture.visible = false;

func show_text(text: String):
	print_debug(text, text_visible);
	
	if(!text_visible):
		text_visible = true
		text_box.clear_text();
		animation_player.play("text_appear");
	
	text_box.show_text(text);
	var complete = yield(text_box, "text_finished_appearing")
	emit_signal("text_finished_appearing", complete);

func show_question(text: String):
	animation_player.play("choice_appear");
	var result = yield(choice, "chosen");
	animation_player.play("choice_disappear")
	emit_signal("choice_made", result);
	
func hide_text():
	if(text_visible):
		animation_player.play("text_disappear");
		text_visible = false;
		text_box.attempt_interrupt()

func _on_Inventory_item_selected(item):
	selected_item_texture.texture = item.image;
	toggle_inventory_open()
	
func toggle_inventory_open():
	if(!inventory_open):
		animation_player.play("inventor_slide_in");
	else:
		animation_player.play("inventor_slide_out");
	inventory_open = !inventory_open;

func open_inventory():
	animation_player.play("inventor_slide_in");
	inventory_open = true;

func _on_Inventory_open_toggled():
	toggle_inventory_open()

func _on_inventory_slide_in():
	print("Slide in")
	if(item_to_add):
		inventory.add_item(item_to_add)
		item_to_add = null

