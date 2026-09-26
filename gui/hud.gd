extends CanvasLayer

@onready var coins_label: Label = %CoinsLabel
@onready var payments_label: Label = %PaymentsLabel
@onready var timer: HBoxContainer = $Control/Timer
@onready var shop: ScrollContainer = $Control/Shop

var payments: Array[String]

func _physics_process(delta: float) -> void:
	coins_label.text = str(PlayerManager.money) + "$"

func add_payment_text(cost: float, _name: String):
	var new_payment: String = "\n-" + str(cost) + "$ (" + _name + ")"
	payments.append(new_payment)
	if payments.size() > 5:
		payments.pop_front()
	payments_label.text = ""
	for s in payments:
		payments_label.text += s
