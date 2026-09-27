extends CanvasLayer

@onready var coins_label: RichTextLabel = %CoinsLabel
@onready var payments_label: Label = %PaymentsLabel
@onready var timer: HBoxContainer = $Control/Timer
@onready var shop: ScrollContainer = $Control/Shop
@onready var game_over: VBoxContainer = $GameOver
@onready var payments_box: VBoxContainer = $Control/VBoxContainer/PaymentsBox
@onready var state_label: Label = $Control/StateLabel

var payments: Array[String]
@export var b_offset: Vector2 = Vector2(0, 10)
@export var time: float = 0.1


func bounce():
	coins_label.offset_transform_enabled = true
	var tween = get_tree().create_tween()
	coins_label.offset_transform_position = b_offset
	tween.tween_property(coins_label, "offset_transform_position", Vector2.ZERO, time)

func _ready() -> void:
	timer.timer.timeout.connect(_on_timer_timeout)
#
#func _physics_process(_delta: float) -> void:
	#if coins_label.text != str(PlayerManager.money):
		#if PlayerManager.money < 0:
			#coins_label.text = "[color=red]" + str(PlayerManager.money) + "$"
		#else:
			#coins_label.text = str(PlayerManager.money) + "$"


func add_payment_text(cost: int, _name: String):
	var new_payment: String = "\n-" + str(cost) + "$ (" + _name + ")"
	payments.push_front(new_payment)
	if payments.size() > 5:
		payments.pop_back()
	payments_label.text = str(payments)
	payments_label.text = ""
	for s in payments:
		payments_label.text += s

func _on_timer_timeout():
	payments = []
	payments_label.text = ""
