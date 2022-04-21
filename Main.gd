extends Node2D

var coin_count: int = 0
onready var player: KinematicBody2D = $Player

func _on_Player_coin_collided(col: Node, coin: Node):
	if col == player:
		add_coins(1)
		coin.queue_free()
	


func add_coins(add: int):
	coin_count += add
	set_coins()

func set_coins():
	$CoinLabel.text = "Coins: " + str(coin_count)
