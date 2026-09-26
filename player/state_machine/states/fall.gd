class_name PlayerFallState extends PlayerState

@export var speed: float = 400
@export var accel: float = 50
@export var gravity: float = 80
var target_speed: float
func init() -> void:
	pass

func enter() -> void:
	if PlayerManager.sub_tags.has("run"):
		target_speed = speed + 200
	else:
		target_speed = speed
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
	player.velocity.y += 60
	player.update_velocity(direction.x * target_speed, accel)
	if player.is_on_floor():
		return idle
	return null
