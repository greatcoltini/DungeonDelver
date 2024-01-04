extends Node

# variables
var hand = preload("res://scenes/hand.tscn").instantiate()
var deck = ["card-burgle", "card-mercenary", "card-move-silent", "card-stumb", "card-mercenary", "card-burgle", "card-mercenary", "card-move-silent", "card-stumb", "card-mercenary"]
var discard = []
var card = preload("res://scenes/card.tscn")
var held_cards = 0
var readied = true

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
		if deck == []:
			pass
		else:
			shuffle_and_deal()
			
func _input(event):
		# check if event is key
		if event is InputEventKey:
			# check key press, and make sure that it is the one expected
			if event.pressed and event.is_action("slide"):
				slide_cards()
		
		
func find_held_cards():
	held_cards = 0
	for child in hand.get_children():
		if child.is_in_group("card"):
			held_cards += 1
	return held_cards
			
func play_card(card):
	hand.remove_child(card)
	position_cards()
	
# Function that positions the player cards
func position_cards(position_x := 100, position_y := 0):
	var card_counter = 0
	for child in hand.get_children():
		if child.is_in_group("card"):
			child.position = Vector2(284 + (position_x * card_counter), 400 + position_y)
			card_counter += 1
			
# Function to slide the player cards to an active vs inactive state
func slide_cards():
	readied = !readied
	
	if readied == false:
		position_cards(100, 150)
	else:
		position_cards(100, 0)
		
	for child in hand.get_children():
		if child.is_in_group("card"):
			child.btn.disabled = !readied
	
