class_name HealthBar
extends HBoxContainer

const EMPTY_HEART = preload("res://scenes/player/health/empty_heart.png")
const HEART = preload("res://scenes/player/health/heart.png")

func _on_player_health_updated(updated_health):
	for index in range(get_child_count()):
		var health_node = get_child(index) as TextureRect
		if index < updated_health:
			health_node.texture = HEART
		else:
			health_node.texture = EMPTY_HEART
