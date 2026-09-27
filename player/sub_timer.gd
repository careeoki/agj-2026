extends Timer

var data: Subscription

func _ready() -> void:
	Hud.timer.timer.timeout.connect(_on_timer_timeout)
	PlayerManager.level_reset.connect(_on_level_reset)
	wait_time = data.time
	start()

func _on_timeout() -> void:
	PlayerManager.add_money(-data.cost)
	Hud.call_deferred("add_payment_text", data.cost, data.sub_name)

func _on_timer_timeout():
	stop()

func _on_level_reset():
	start()
