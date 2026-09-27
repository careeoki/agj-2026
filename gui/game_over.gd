extends VBoxContainer

func _ready() -> void:
	hide()

func open():
	PlayerManager.return_player_to_spawn()
	show()
	

func _on_restart_button_pressed() -> void:
	PlayerManager.reset_data()
	PlayerManager.player_exit_cutscene()
	hide()
	
