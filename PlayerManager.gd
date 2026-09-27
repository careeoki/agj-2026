extends Node

signal level_reset
signal data_reset
const SUB_TIMER = preload("uid://2vlc2yxttf1n")

var player: Player
var spawn_pos: Vector2
var money: int = 0

var subscriptions: Array[Subscription]
var sub_tags: Array[String]

func reset_data():
	money = 0
	Hud.coins_label.text = "0$"
	subscriptions = []
	sub_tags = []
	Hud.payments.clear()
	Hud.payments_label.text = ""
	Hud.timer.timer.wait_time = 5.0
	player.reset_stat_changes()
	for c in get_children():
		c.queue_free()
	data_reset.emit()

func add_new_sub(data: Subscription):
	if subscriptions.has(data):
		subscriptions.get(subscriptions.find(data)).cost += data.cost
		sub_tags.append(data.tag)
	else:
		subscriptions.append(data)
		sub_tags.append(data.tag)
		var new_sub = SUB_TIMER.instantiate()
		new_sub.data = data
		add_child(new_sub)

func return_player_to_spawn():
	player.global_position = spawn_pos
	player.player_state_machine.change_state(player.player_state_machine.states[0].cutscene)

func add_money(amount: int):
	money += amount
	if money < 0:
		Hud.coins_label.text = "[color=red]" + str(money) + "$"
	else:
		Hud.coins_label.text = str(money) + "$"
	Hud.bounce()

func player_exit_cutscene():
	player.player_state_machine.change_state(player.player_state_machine.states[0].idle)
	player.update_target_speed()
	level_reset.emit()
