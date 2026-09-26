extends Node2D

@export var value: int = 1

func _on_area_2d_body_entered(_body: Node2D) -> void:
	PlayerManager.money += value
	queue_free()
