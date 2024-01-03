extends Node

# variables
var hand = []
var deck = ["card-burgle", "card-mercenary", "card-move-silent", "card-stumb", "card-mercenary"]
var discard = []
# constants
const HAND_SIZE = 5



func _init():
	shuffle_and_deal()
	
func shuffle_and_deal():
	while hand.size() < HAND_SIZE:
		randomize()
		deck.shuffle()
		hand.append(deck.pop_back())
		print(hand)
		print(deck)
	
func _process(delta):
	if hand == []:
		shuffle_and_deal()
	
