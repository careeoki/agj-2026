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
	print("WA it")
	pass

func exit() -> void:
	print("not WA t")
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	if _event.is_action_pressed("jump"):
		return jump
	return null

func process(_delta: float) -> PlayerState:
	return null

func physics_process(_delta: float) -> PlayerState:
	if !direction.x:
		return idle
	
	player.update_velocity(direction.x * speed, accel)
	return null
