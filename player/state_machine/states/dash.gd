class_name PlayerDashState extends PlayerState

@export var jump_velocity: float = 800
@export var speed: float = 400
@export var accel: float = 50

var target_speed: float
func init() -> void:
	pass

func enter() -> void:
	if player.velocity.y > 0:
		player.velocity.y = 0
	player.velocity.x = (player.target_speed + player.target_dash) * direction.x
	player.sprite.scale = Vector2(0.7, 1.3)
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> PlayerState: #dash exit with air jymp
	return null

func process(_delta: float) -> PlayerState:
	return null

func physics_process(_delta: float) -> PlayerState:
	player.velocity.y += player.target_gravity -5
	player.update_velocity(0, 10)
	if player.velocity.x < 500 * sign(player.velocity.x):
		return idle
	if player.is_on_floor():
		return idle
	return null
