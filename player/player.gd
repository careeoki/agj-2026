class_name Player extends CharacterBody2D

@onready var player_state_machine: PlayerStateMachine = $PlayerStateMachine


func _ready() -> void:
	player_state_machine.init(self)

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta
	
	
	move_and_slide()

func update_velocity(_velocity: float, _accel) -> void:
	velocity.x = move_toward(velocity.x, _velocity, _accel)
	pass
