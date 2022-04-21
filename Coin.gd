extends Area2D

onready var main = get_parent()

func _ready() -> void:
	connect("body_entered", main, "_on_Player_coin_collided", [self])

