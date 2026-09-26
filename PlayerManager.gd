extends Node
const SUB_TIMER = preload("uid://2vlc2yxttf1n")

var player: Player
var spawn_pos: Vector2
var money: int = 0

var subscriptions: Array[Subscription]
var sub_tags: Array[String]

func add_new_sub(data: Subscription):
	subscriptions.append(data)
	sub_tags.append(data.tag)
	var new_sub = SUB_TIMER.instantiate()
	new_sub.data = data
	add_child(new_sub)

func return_player_to_spawn():
	player.global_position = spawn_pos
	player.player_state_machine.change_state(player.player_state_machine.states[0].cutscene)

func player_exit_cutscene():
	player.player_state_machine.change_state(player.player_state_machine.states[0].idle)
