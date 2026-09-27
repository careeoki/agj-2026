extends Timer

var data: Subscription
var additional_cost: int = 0

func _ready() -> void:
	Hud.timer.timer_timeout.connect(_on_timer_timeout)
	PlayerManager.level_reset.connect(_on_level_reset)
	wait_time = data.time
	start()

func _on_timeout() -> void:
	PlayerManager.add_money(-(data.cost + additional_cost))
	Hud.call_deferred("add_payment_text", data.cost + additional_cost, data.sub_name)

func _on_timer_timeout():
	stop()

func _on_level_reset():
	start()
