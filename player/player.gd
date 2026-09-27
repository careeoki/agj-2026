class_name Player extends CharacterBody2D

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine

@export var default_speed: float = 400
@export var default_jump: float = 900
@export var default_accel: float = 10
@export var default_gravity: float = 40
@export var default_swim_power: float = 10

var max_air_jumps: int = 0
var air_jumps: int = 0
var target_speed
var target_accel
var target_jump
var target_gravity
var target_swim_power
@onready var sprite: Sprite2D = $Sprite2D
@onready var camera: Camera2D = $Camera2D

var underwater: bool = false

func _ready() -> void:
	target_speed = default_speed
	target_accel = default_accel
	target_gravity = default_gravity
	target_jump = 0
	target_swim_power = default_swim_power
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

func update_target_speed(): #this was not working correctly for the past few hours and i did not know.
	target_speed = default_speed
	target_accel = default_accel
	#target_jump = default_jump
	target_swim_power = default_swim_power
	max_air_jumps = 0
	for r in PlayerManager.sub_tags.count("run"):
		target_speed += 100
	for r in PlayerManager.sub_tags.count("extra_jump"):
		max_air_jumps += 1
	air_jumps = max_air_jumps
	target_jump = default_jump + 100 * (PlayerManager.sub_tags.count("jump") - 1)
	print(PlayerManager.sub_tags.count("jump"))
		
	for a in PlayerManager.sub_tags.count("accel"):
		target_accel += 15
	for s in PlayerManager.sub_tags.count("swim"):
		target_swim_power += 10

func update_velocity(_velocity: float, _accel) -> void:
	velocity.x = move_toward(velocity.x, _velocity, _accel)
	pass

func reset_stat_changes():
	target_speed = default_speed
	target_jump = default_jump
	target_accel = default_accel
	target_gravity = default_gravity
	target_swim_power = default_swim_power
	
	max_air_jumps = 0
	air_jumps = 0


func _on_water_check_body_entered(_body: Node2D) -> void:
	print("in water")

	if PlayerManager.sub_tags.has("swim"):
		underwater = true
		player_state_machine.change_state(player_state_machine.states[0].swim)
		target_gravity = 5
	else:
		die()


func _on_water_check_body_exited(_body: Node2D) -> void:
	target_gravity = default_gravity
	underwater = false


func _on_hit_box_body_entered(_body: Node2D) -> void:
	die()

func die():
	PlayerManager.add_money(-50)
	Hud.add_payment_text(50, "Medical Bills")
	Hud.timer.timer.stop()
	Hud.timer._on_timer_timeout()
