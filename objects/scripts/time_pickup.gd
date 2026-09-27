extends Node2D

@export var time_added: float = 5.0
@onready var area_2d: Area2D = $Area2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	PlayerManager.data_reset.connect(_on_data_reset)





func _on_area_2d_body_entered(_body: Node2D) -> void:
	area_2d.set_deferred("monitoring", false)
	Hud.timer.add_time(time_added)
	hide()

func _on_data_reset():
	if not visible:
		show()
		area_2d.set_deferred("monitoring", true)
