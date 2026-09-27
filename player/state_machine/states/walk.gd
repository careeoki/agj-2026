class_name PlayerWalkState extends PlayerState

@export var speed: float = 400
@export var accel: float = 50
@export var skid_accel: float = 100

var current_accel: float
var current_direction: float = 0
var target_speed: float

func init() -> void:
	pass

func enter() -> void:
	current_accel = accel
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump") and PlayerManager.sub_tags.has("jump"):
		return jump
	return null

func process(_delta: float) -> PlayerState:
	return null

func physics_process(_delta: float) -> PlayerState:
	if not player.is_on_floor():
		return fall
	if !direction.x:
		return idle
	elif sign(direction.x) == sign(player.velocity.x) or player.velocity.x == 0:
		current_accel = player.target_accel
	else:
		current_accel = player.target_accel * 2
	
	player.update_velocity(direction.x * player.target_speed, current_accel)
	return null
