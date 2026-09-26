extends Timer

var data: Subscription

func _ready() -> void:
	Hud.timer.timer.timeout.connect(_on_timer_timeout)
	wait_time = data.time
	start()

func _on_timeout() -> void:
	PlayerManager.money -= data.cost
	Hud.add_payment_text(data.cost, data.sub_name)

func _on_timer_timeout():
	stop()
