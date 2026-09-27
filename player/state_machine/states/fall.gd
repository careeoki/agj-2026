class_name PlayerFallState extends PlayerState

@export var speed: float = 400
@export var accel: float = 50
@export var gravity: float = 80
@export var coyote_time: float = 0.125
var target_speed: float

var coyote_timer: float = 0

func init() -> void:
	pass

func enter() -> void:
	if state_machine.previous_state == jump:
		coyote_timer = 0
	else:
		coyote_timer = coyote_time
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	if coyote_timer > 0:
		if _event.is_action_pressed("jump") and PlayerManager.sub_tags.has("jump"):
			return jump
	
	if _event.is_action_released("jump") and player.velocity.y < 0:
		player.velocity.y *= 0.5
	if _event.is_action_pressed("jump") and PlayerManager.sub_tags.has("extra_jump") and player.air_jumps > 0:
		player.air_jumps -= 1
		player.velocity.y = -player.target_jump * 0.8
		player.sprite.scale = Vector2(0.7, 1.3)
	return null

func process(_delta: float) -> PlayerState:
	return null

func physics_process(_delta: float) -> PlayerState:
	player.velocity.y += player.target_gravity + 10
	player.update_velocity(direction.x * player.target_speed, player.target_accel)
	if player.is_on_floor():
		player.air_jumps = player.max_air_jumps
		return idle
	return null
