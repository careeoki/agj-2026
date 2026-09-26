class_name PlayerStateMachine extends Node2D

var states: Array[PlayerState]
var current_state: PlayerState:
	get: return states.front()
var previous_state: PlayerState:
	get: return states[1]

var player: Player

func _ready() -> void:
	process_mode = Node.PROCESS_MODE_DISABLED
	pass

func _process(_delta: float) -> void:
	current_state.direction = Vector2(Input.get_axis("left", "right"), 0)
	var new_state = current_state.process(_delta)
	change_state(new_state)
	pass

func _physics_process(_delta: float) -> void:
	var new_state = current_state.physics_process(_delta)
	change_state(new_state)
	pass

func _unhandled_input(event: InputEvent) -> void:
	var new_state = current_state.handle_input(event)
	change_state(new_state)
	pass

func change_state(new_state: PlayerState) -> void:
	if new_state == null:
		return
	elif new_state == current_state:
		return
	
	if current_state:
		current_state.exit()
	
	states.push_front(new_state)
	current_state.enter()
	states.resize(3)
	print(states)
	
	pass

func init(_player: Player) -> void:
	player = _player
	states = []
	
	for c in get_children():
		if c is PlayerState:
			states.append(c)
	print("init " + str(states.size()) + " states")
	if states.size() == 0:
		return
	
	
	current_state.player = player
	current_state.state_machine = self
	
	for s in states:
		s.init()
	
	change_state(previous_state)
	change_state(previous_state)
	process_mode = Node.PROCESS_MODE_INHERIT
	
	pass
