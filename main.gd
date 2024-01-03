extends Node2D


var cards = []
var card_types = ["card-burgle", "card-mercenary", "card-move-silent", "card-stumb"]

# Called when the node enters the scene tree for the first time.
func _ready():
	cards = get_tree().get_nodes_in_group("card");
	
	for i in cards.size():
		cards[i].set_texture(card_types[i]);
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
