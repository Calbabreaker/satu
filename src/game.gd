extends Control

var card_scene := preload("res://src/card/card.tscn")
var card_played: Node

func _ready():
	add_playpile(instance_card())
	randomize()

func _on_DrawPile_button_down() -> void:
	var new_card := instance_card()
	$Hand.add_child(new_card)
	update_hand_spacing()
	
	# move the card into the correct ordered place
	var cards = $Hand.get_children()
	for i in len(cards):
		if new_card.is_lower_value(cards[i]):
			$Hand.move_child(new_card, i)
			break

func _on_Card_button_down(card: Node) -> void:
	play_card(card)

func play_card(card: Node) -> void:
	if card.matches_color(card_played) or card.matches_number(card_played):
		card_played.queue_free()
		$Hand.remove_child(card)
		update_hand_spacing()

		add_playpile(card)

func add_playpile(card: Node) -> void:
	$Playpile.add_child(card)
	card.rect_position.x = 0
	card.disconnect("button_down", self, "_on_Card_button_down")
	card_played = card

func instance_card() -> Node:
	var color_index := randi() % 4
	# only supports 0-4 card types right now
	var type := str(randi() % 5)
	var card = card_scene.instance().init(type, color_index)
	card.connect("button_down", self, "_on_Card_button_down", [card])
	return card

func update_hand_spacing() -> void:
	var cards = $Hand.get_children()
	if len(cards) == 0: return
	
	var hand_size = $Hand.rect_size.x / 1.5;
	var space_remaining: float = hand_size - cards[0].rect_size.x * len(cards)
	var spacing: float = space_remaining / len(cards) - 1
	$Hand.add_constant_override("separation", min(spacing, -40))
