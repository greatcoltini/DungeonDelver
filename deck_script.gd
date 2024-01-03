extends Node

# variables
var hand = preload("res://scenes/hand.tscn").instantiate()
var deck = ["card-burgle", "card-mercenary", "card-move-silent", "card-stumb", "card-mercenary"]
var discard = []
var card = preload("res://scenes/card.tscn")
var held_cards = 0

# constants
const HAND_SIZE = 5



func initialize():	
	hand.position = Vector2(584, 551)
	get_tree().get_first_node_in_group("main").add_child(hand)
	
	shuffle_and_deal()
	
func shuffle_and_deal():
	
	find_held_cards()
	while held_cards < HAND_SIZE:
		randomize()
		deck.shuffle()
		var temp_card = card.instantiate()
		temp_card.set_texture(deck.pop_back())
		hand.add_child(temp_card)
		temp_card.position = Vector2(284 + (100 * held_cards), 400)
		held_cards += 1
	
func _process(delta):
	if find_held_cards() == 0:
		shuffle_and_deal()
		
func find_held_cards():
	held_cards = 0
	for child in hand.get_children():
		if child.is_in_group("card"):
			held_cards += 1
			
func play_card(card):
	hand.remove_child(card)
	
func position_cards():
	find_held_cards()
	
