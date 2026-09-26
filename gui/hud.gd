extends CanvasLayer

@onready var coins_label: Label = %CoinsLabel

func _physics_process(delta: float) -> void:
	coins_label.text = str(PlayerManager.money)
