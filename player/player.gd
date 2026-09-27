class_name Player extends CharacterBody2D

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine

@export var default_speed: float = 400
@export var default_jump: float = 860
@export var default_accel: float = 10

var max_air_jumps: int = 0
var air_jumps: int = 0
var target_speed
var target_accel
var target_jump
@onready var sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = $Camera2D

func _ready() -> void:
	target_speed = default_speed
	target_accel = default_accel
	target_jump = 0
	player_state_machine.init(self)
	PlayerManager.player = self
	PlayerManager.spawn_pos = global_position

func _physics_process(delta: float) -> void:
	#if not is_on_floor():
		#velocity += get_gravity() * delta
	sprite.scale.x = move_toward(sprite.scale.x, 1, 1.2 * delta)
	sprite.scale.y = move_toward(sprite.scale.y, 1, 1.2 * delta)
	
	if not is_on_floor():
		camera.drag_vertical_enabled = true
	else:
		camera.drag_vertical_enabled = false
	
	move_and_slide()

func update_target_speed():
	target_speed = default_speed
	target_accel = default_accel
	for r in PlayerManager.sub_tags.count("run"):
		target_speed += 200
	for r in PlayerManager.sub_tags.count("extra_jump"):
		max_air_jumps += 1
	air_jumps = max_air_jumps
	for j in PlayerManager.sub_tags.count("jump"):
		if target_jump == 0:
			target_jump += 840
		else:
			target_jump += 100
	for a in PlayerManager.sub_tags.count("accel"):
		target_accel += 15

func update_velocity(_velocity: float, _accel) -> void:
	velocity.x = move_toward(velocity.x, _velocity, _accel)
	pass

func reset_stat_changes():
	target_speed = default_speed
	target_jump = default_jump
	target_accel = default_accel
	
	max_air_jumps = 0
	air_jumps = 0
