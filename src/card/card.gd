extends TextureRect

var color: Color
var type: String

func init(p_color: Color, p_type: String) -> Node:
	color = p_color
	type = p_type
	var texture_specific = load("res://assets/cards/card_" + type + ".svg")
	var texture_specific_modulate = load("res://assets/cards/card_" + type + "_modulate.svg")
	$TextureSpecific.texture = texture_specific
	$Front/TextureSpecificModulate.texture = texture_specific_modulate
	$Front.modulate = color
	return get_node(".")
