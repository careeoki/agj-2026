class_name PlayerState extends Node2D

static var player: Player

static var state_machine: PlayerStateMachine
static var direction: Vector2

@onready var idle: PlayerIdleState = %Idle
@onready var walk: PlayerWalkState = %Walk
@onready var jump: PlayerJumpState = %Jump
@onready var fall: PlayerFallState = %Fall
@onready var cutscene: PlayerCutsceneState = %Cutscene


func _ready() -> void:
	pass

func init() -> void:
	pass

func enter() -> void:
	pass

func exit() -> void:
	pass

func handle_input(_event: InputEvent) -> PlayerState:
	return null

func process(_delta: float) -> PlayerState:
	return null

func physics_process(_delta: float) -> PlayerState:
	return null
