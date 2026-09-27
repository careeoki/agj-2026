extends PanelContainer

signal subbed

@onready var sub_icon: TextureRect = %SubIcon
@onready var name_label: Label = %NameLabel
@onready var desc_label: Label = %DescLabel
@onready var stats_label: Label = %StatsLabel
@onready var sub_button: Button = %SubButton


var data: Subscription
var is_subbed: bool = false

func _ready() -> void:
	name_label.text = data.sub_name
	desc_label.text = data.desc
	stats_label.text = str(data.cost) + "$ every " + str(data.time) + "s"
	sub_icon.texture = load("res://assets/gui/sub_icons/" + data.tag + ".png")


func _on_sub_button_pressed() -> void:
	#if is_subbed:
		#return
	#is_subbed = true
	PlayerManager.add_new_sub(data)
	subbed.emit()
