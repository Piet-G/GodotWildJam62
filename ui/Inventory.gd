extends NinePatchRect

onready var grid = $GridContainer;

signal item_selected(item);
signal open_toggled();

func _ready():
	build_inventory(MapManager.get_player().get_inventory())

func build_inventory(inventory):
	for item in inventory:
		var item_button = preload("res://ui/ItemButton.tscn").instance()
		grid.add_child(item_button);
		item_button.set_item(item);
		item_button.connect("pressed", self, "_inventory_button_pressed", [item])

func _inventory_button_pressed(item):
	emit_signal("item_selected", item);
	$AudioStreamPlayer.play(0.05)

func add_item(item):
	var item_button = preload("res://ui/ItemButton.tscn").instance()
	item_button.visible = false;
	grid.add_child(item_button);
	item_button.set_item(item);
	item_button.connect("pressed", self, "_inventory_button_pressed", [item])
	item_button.appear()

func _on_ToggleInventoryButton_pressed():
	emit_signal("open_toggled")
