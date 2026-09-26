extends Node2D

@export var value: int = 1
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D

func _ready() -> void:
	Hud.timer.timer.timeout.connect(_on_timer_timeout)
	sprite.frame += int(global_position.x)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	PlayerManager.money += value
	area_2d.set_deferred("monitoring", false)
	hide()


func _on_timer_timeout():
	if not visible:
		area_2d.set_deferred("monitoring", true)
		show()
