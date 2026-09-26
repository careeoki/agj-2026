class_name PlayerJumpState extends PlayerState

@export var jump_velocity: float = 800
@export var speed: float = 400
@export var accel: float = 50

func init() -> void:
	pass

func enter() -> void:
	print("J it")
	player.velocity.y -= jump_velocity
	pass

func exit() -> void:
	print("not J t")
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_released("jump"):
		player.velocity.y *= 0.5
	return null

func process(_delta: float) -> PlayerState:
	return null

func physics_process(_delta: float) -> PlayerState:
	player.update_velocity(direction.x * speed, accel)
	if player.velocity.y > 0:
		return fall
	return null
