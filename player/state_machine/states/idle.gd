class_name PlayerIdleState extends PlayerState

func init() -> void:
	pass

func enter() -> void:
	print("idling it")
	pass

func exit() -> void:
	print("not idliingi t")
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return null

func process(_delta: float) -> PlayerState:

	return null

func physics_process(_delta: float) -> PlayerState:
	player.update_velocity(0, 50)
	if direction.x:
		return walk
	if not player.is_on_floor():
		return fall
	return null
