extends Node


func _process(_delta: float) -> void:
	if Input.is_key_pressed(KEY_F3) and Hud.timer.timer.time_left > 0:
		Hud.shop.max_size = 66
		Hud.timer.timer.stop()
		Hud.timer._on_timer_timeout()
