class_name PlayerJumpState extends PlayerState

@export var jump_velocity: float = 800
@export var speed: float = 400
@export var accel: float = 50

var target_speed: float
func init() -> void:
	pass

func enter() -> void:
	player.velocity.y = -player.target_jump
	player.sprite.scale = Vector2(0.7, 1.3)
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_released("jump"):
		player.velocity.y *= 0.5
	if _event.is_action_pressed("jump") and PlayerManager.sub_tags.has("extra_jump") and player.air_jumps > 0:
		player.air_jumps -= 1
		player.velocity.y = -player.target_jump * 0.8
		player.sprite.scale = Vector2(0.7, 1.3)
	return null

func process(_delta: float) -> PlayerState:
	return null

func physics_process(_delta: float) -> PlayerState:
	player.velocity.y += player.target_gravity
	player.update_velocity(direction.x * player.target_speed, player.target_accel)
	if player.velocity.y > 0:
		return fall
	return null
