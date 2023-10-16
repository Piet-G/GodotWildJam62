extends Control

class SoundEffect:
	var player
	var weight
	
	func _init(player, weight):
		self.player = player;
		self.weight = weight;

onready var sounds = [
	SoundEffect.new($Wind, 10), SoundEffect.new($Notes, 20)
]

func _ready():
	$Timer.start(generate_next_time());

func generate_next_time():
	return rand_range(20, 60);

func _on_Timer_timeout():
	var max_weight = 0;
	
	for effect in sounds:
		max_weight += effect.weight;
	
	var current_weight = 0;
	var desired_weight = rand_range(0, max_weight);
	var player: AudioStreamPlayer
	
	for effect2 in sounds:
		current_weight += effect2.weight;
		
		if(current_weight >= desired_weight):
			player = effect2.player
			break;
	
	player.play();
	$Timer.start(generate_next_time())
