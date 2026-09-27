extends Node2D

@export var value: int = 1
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var area_2d: Area2D = $Area2D
@onready var collect: AudioStreamPlayer2D = $Collect

func _ready() -> void:
	PlayerManager.level_reset.connect(_on_level_reset)
	sprite.frame += int(global_position.x)

func _on_area_2d_body_entered(_body: Node2D) -> void:
	PlayerManager.add_money(value)
	area_2d.set_deferred("monitoring", false)
	collect.play()
	hide()


func _on_level_reset():
	if not visible:
		area_2d.set_deferred("monitoring", true)
		show()
