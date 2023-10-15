extends TextureButton

onready var name_label = get_node("%NameLabel");
onready var item_image = get_node("%ItemImage");

func set_item(item: Item):
	name_label.text = item.name;
	item_image.texture = item.image;

func appear():
	$AnimationPlayer.play("appear")
