class_name PlayerCutsceneState extends PlayerState

func init() -> void:
	pass

func enter() -> void:
	player.sprite.play("idle")
	player.velocity = Vector2.ZERO
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	return null

func process(_delta: float) -> PlayerState:

	return null

func physics_process(_delta: float) -> PlayerState:
	return null
