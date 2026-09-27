extends VBoxContainer

@onready var stats_label: Label = $StatsLabel


func open():
	show()
	stats_label.text = "Subscriptions: " + str(PlayerManager.sub_tags.size()) + "\nClocks Found: " + str(int(Hud.timer.additional_time / 5)) + "/8"

func _on_restart_button_pressed() -> void:
	PlayerManager.reset_data()
	PlayerManager.return_player_to_spawn()
	PlayerManager.player_exit_cutscene()
	hide()
	
