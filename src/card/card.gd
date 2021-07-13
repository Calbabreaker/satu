extends TextureButton

const card_colors := [
	Color(0xd40b1fff), # red
	Color(0x143dc9ff), # blue
	Color(0xf2ce02ff), # yellow
	Color(0x0fb82bff), # green
]

var color: Color
var color_index: int
var type: String

func init(p_type: String, p_color_index: int) -> Node:
	color_index = p_color_index
	type = p_type
	set_color(card_colors[color_index])
	var texture_specific = load("res://assets/cards/card_" + type + ".svg")
	var texture_specific_modulate = load("res://assets/cards/card_" + type + "_modulate.svg")
	$TextureSpecific.texture = texture_specific
	$Front/TextureSpecificModulate.texture = texture_specific_modulate
	return get_node(".")

func set_color(p_color: Color):
	color = p_color
	$Front.modulate = color

# these won't work with wildcards yet
func is_lower_value(card: Node) -> bool:
	var lower_type = int(type) < int(card.type)
	var lower_color = color_index < card.color_index
	return lower_color or (matches_color(card) and lower_type)
	
func matches_color(card: Node) -> bool:
	return color_index == card.color_index

func matches_number(card: Node) -> bool:
	return type == card.type
