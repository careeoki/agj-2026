extends HBoxContainer

@onready var timer_icon: TextureRect = $TimerIcon
@onready var time_label: Label = $TimeLabel
@onready var timer: Timer = $Timer

func _ready() -> void:
	timer.start()

func _process(delta: float) -> void:
	time_label.text = str(snapped(timer.time_left, 0.01))


func _on_timer_timeout() -> void:
	Hud.shop.open_shop()
	PlayerManager.return_player_to_spawn()
	
