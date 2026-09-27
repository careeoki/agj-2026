extends HBoxContainer

signal timer_timeout

@onready var timer_icon: TextureRect = $TimerIcon
@onready var time_label: Label = $TimeLabel
@onready var timer: Timer = $Timer
@onready var ding_sound: AudioStreamPlayer = $DingSound
@onready var plus_time_label: Label = $"../PlusTimeLabel"

var additional_time: float = 0

func _ready() -> void:
	PlayerManager.data_reset.connect(_on_data_reset)
	plus_time_label.hide()
	timer.start()

func _process(_delta: float) -> void:
	time_label.text = str(snapped(timer.time_left, 0.1))


func _on_timer_timeout() -> void:
	timer_timeout.emit()
	if PlayerManager.money < 0:
		print("game over!")
		Hud.game_over.open()
		return
	Hud.shop.open_shop()
	PlayerManager.return_player_to_spawn()
	ding_sound.play()
	

func add_time(time_added: float):
	additional_time += time_added
	if timer.time_left == 0:
		return
	var new_time = timer.wait_time + time_added
	timer.wait_time = timer.time_left + time_added
	timer.stop()
	timer.start()
	timer.wait_time = new_time
	plus_time_anim()
	
func _on_data_reset():
	timer.start()

func start_timer():
	timer.wait_time = 5 + additional_time
	timer.start()

func plus_time_anim():
	plus_time_label.show()
	await get_tree().create_timer(2).timeout
	plus_time_label.hide()
	
