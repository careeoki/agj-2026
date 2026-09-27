extends HBoxContainer

signal timer_timeout

@onready var timer_icon: TextureRect = $TimerIcon
@onready var time_label: Label = $TimeLabel
@onready var timer: Timer = $Timer

func _ready() -> void:
	PlayerManager.data_reset.connect(_on_data_reset)
	timer.start()

func _process(_delta: float) -> void:
	time_label.text = str(snapped(timer.time_left, 0.1))


func _on_timer_timeout() -> void:
	if PlayerManager.money < 0:
		print("game over!")
		Hud.game_over.open()
		return
	Hud.shop.open_shop()
	PlayerManager.return_player_to_spawn()
	timer_timeout.emit()

func add_time(time_added: float):
	if timer.time_left == 0:
		return
	var new_time = timer.wait_time + time_added
	timer.wait_time = timer.time_left + time_added
	timer.stop()
	timer.start()
	timer.wait_time = new_time
	
func _on_data_reset():
	timer.start()
