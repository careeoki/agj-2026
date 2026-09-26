extends PanelContainer

signal subbed

@onready var name_label: Label = $VBoxContainer/NameLabel
@onready var desc_label: Label = $VBoxContainer/DescLabel
@onready var stats_label: Label = $VBoxContainer/StatsLabel
@onready var sub_button: Button = $VBoxContainer/SubButton

var data: Subscription
var is_subbed: bool = false

func _ready() -> void:
	name_label.text = data.sub_name
	desc_label.text = data.desc
	stats_label.text = str(data.cost) + "$ every " + str(data.time) + "s"


func _on_sub_button_pressed() -> void:
	if is_subbed:
		return
	is_subbed = true
	PlayerManager.add_new_sub(data)
	subbed.emit()
