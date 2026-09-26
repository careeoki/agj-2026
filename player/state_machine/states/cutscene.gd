class_name PlayerCutsceneState extends PlayerState

func init() -> void:
	pass

func enter() -> void:
	player.velocity = Vector2.ZERO
	print("cut")
	pass

func exit() -> void:
	print("uncut")
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	return null

func process(_delta: float) -> PlayerState:

	return null

func physics_process(_delta: float) -> PlayerState:
	return null
