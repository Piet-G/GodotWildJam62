extends TextureButton

onready var name_label = get_node("%NameLabel");
onready var item_image = get_node("%ItemImage");
onready var description_label = get_node("%DescriptionLabel");

func set_item(item: Item):
	name_label.text = item.name;
	item_image.texture = item.image;
	description_label.text = item.description;

func appear():
	$AnimationPlayer.play("appear")
