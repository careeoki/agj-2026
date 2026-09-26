class_name PlayerFallState extends PlayerState

@export var speed: float = 400
@export var accel: float = 50

func init() -> void:
	pass

func enter() -> void:
	print("F it")
	pass

func exit() -> void:
	print("not F t")
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	return null

func process(_delta: float) -> PlayerState:
	return null

func physics_process(_delta: float) -> PlayerState:
	player.update_velocity(direction.x * speed, accel)
	if player.is_on_floor():
		return idle
	return null
