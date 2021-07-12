extends Control

var card_scene = preload("res://src/card/card.tscn")

func _ready():
	var card = card_scene.instance().init(Color.firebrick, "1")
	$Grid.add_child(card)
