class_name Player extends CharacterBody2D
const AIR_JUMP_POOF = preload("uid://b8r02rco7ph8b")
const JUMP_POOF = preload("uid://4hutrfi2nc7k")

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine
@onready var jump_sound: AudioStreamPlayer2D = $JumpSound
@onready var air_jump_sound: AudioStreamPlayer2D = $AirJumpSound
@onready var hurt_sound: AudioStreamPlayer2D = $HurtSound
@onready var splash_sound: AudioStreamPlayer2D = $SplashSound
@onready var dash_sound: AudioStreamPlayer2D = $DashSound

@export var default_speed: float = 450
@export var default_jump: float = 850
@export var default_accel: float = 15
@export var default_gravity: float = 40
@export var default_swim_power: float = 10
@export var default_dash: float = 500

var max_air_jumps: int = 0
var air_jumps: int = 0
var target_speed
var target_accel
var target_jump
var target_gravity
var target_dash
var target_swim_power
@onready var sprite: AnimatedSprite2D = $Sprite2D
@onready var camera: Camera2D = $Camera2D

var underwater: bool = false
var current_direction: int = 1

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
	if player_state_machine.states[0].direction.x != current_direction and not player_state_machine.states[0].direction.x == 0:
		change_direction()
	
	if not is_on_floor():
		camera.drag_vertical_enabled = true
	else:
		camera.drag_vertical_enabled = false
	
	move_and_slide()

func change_direction():
	if current_direction == -1:
		sprite.flip_h = false
		current_direction = 1
	else:
		sprite.flip_h = true
		current_direction = -1

func update_target_speed(): #this was not working correctly for the past few hours and i did not know.
	target_speed = default_speed
	target_accel = default_accel
	#target_jump = default_jump
	target_swim_power = default_swim_power
	max_air_jumps = 0
	for r in PlayerManager.sub_tags.count("run"):
		target_speed += 120
	for r in PlayerManager.sub_tags.count("extra_jump"):
		max_air_jumps += 1
	air_jumps = max_air_jumps
	target_jump = default_jump + 140 * (PlayerManager.sub_tags.count("jump") - 1)
	target_dash = default_dash + 130 * (PlayerManager.sub_tags.count("dash") - 1)
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
	splash_sound.play()

func _on_water_check_body_exited(_body: Node2D) -> void:
	target_gravity = default_gravity
	underwater = false


func _on_hit_box_body_entered(_body: Node2D) -> void:
	die()

func die():
	play_hurt()
	PlayerManager.add_money(-50)
	Hud.add_payment_text(50, "Medical Bills")
	Hud.timer.timer.stop()
	Hud.timer._on_timer_timeout()

func air_jump_poof():
	play_air_jump()
	var poof = AIR_JUMP_POOF.instantiate()
	poof.global_position = global_position
	get_tree().current_scene.call_deferred("add_child", poof)

func jump_poof():
	var poof = JUMP_POOF.instantiate()
	poof.global_position = sprite.global_position
	get_tree().current_scene.call_deferred("add_child", poof)

func play_jump():
	jump_sound.pitch_scale = randf_range(0.9, 1.1)
	jump_sound.play()

func play_air_jump():
	air_jump_sound.pitch_scale = 1 - float(air_jumps) * 0.1
	air_jump_sound.play()

func play_hurt():
	hurt_sound.pitch_scale = randf_range(0.9, 1.1)
	hurt_sound.play()

func play_splash():
	splash_sound.pitch_scale = randf_range(1.0, 1.2)
	splash_sound.play()

func play_dash():
	dash_sound.pitch_scale = randf_range(1.0, 1.2)
	dash_sound.play()
