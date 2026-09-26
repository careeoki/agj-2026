class_name PlayerJumpState extends PlayerState

@export var jump_velocity: float = 800
@export var speed: float = 400
@export var accel: float = 50

var target_speed: float
func init() -> void:
	pass

func enter() -> void:
	if PlayerManager.sub_tags.has("run"):
		target_speed = speed + 200
	else:
		target_speed = speed
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
	player.velocity.y += 40
	player.update_velocity(direction.x * target_speed, accel)
	if player.velocity.y > 0:
		return fall
	return null
