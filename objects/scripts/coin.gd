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
	collect_anim()

func _on_level_reset():
	if not visible:
		area_2d.set_deferred("monitoring", true)
		show()
	sprite.stop()
	sprite.frame = 0
	sprite.play("default")

func collect_anim():
	var tween = get_tree().create_tween()
	tween.tween_property(sprite, "position:y", -40, 0.2).set_ease(Tween.EASE_OUT).set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(sprite, "position:y", -10, 0.2).set_ease(Tween.EASE_IN).set_trans(Tween.TRANS_CUBIC)
	sprite.z_index = 2
	sprite.speed_scale = 4
	await tween.finished
	hide()
	sprite.position.y = 0
	
	sprite.speed_scale = 1
	sprite.z_index = 0
	sprite.stop()
