extends ScrollContainer
const SUBSCRIPTION_BOX = preload("uid://0ha7moh00yed")

var max_size: int = 3
var data: Array[Subscription]
@onready var vbox: VBoxContainer = %VBoxContainer
@onready var kaching_sound: AudioStreamPlayer = $KachingSound
@onready var subs_label: Label = %SubsLabel

func _ready() -> void:
	hide()
	subs_label.get_parent().hide()
	create_shop_data()

func open_shop():
	create_shop_data()
	var subs_text: String = "Your Subscriptions:"
	for s in PlayerManager.subscriptions:
		subs_text += "\n" + s.data.sub_name + ": " + str(PlayerManager.sub_tags.count(s.data.tag))
	subs_label.text = subs_text
	subs_label.get_parent().show()
	show()

func create_shop_data():
	var data_array: Array[Subscription]
	for file_name in DirAccess.get_files_at("res://subscriptions/"):
		if (file_name.get_extension() == "remap"):
			file_name = file_name.replace('.remap', '')
		file_name = "res://subscriptions/"+file_name
		
		data_array.append(load(file_name))
	
	if max_size == 3:
		data_array.shuffle()
	if max_size > 0 and data_array.size() > max_size:
		data_array.resize(max_size)
	data = data_array
	update_inventory()

func update_inventory() -> void:
	if vbox.get_children().size() > 0:
		for c in vbox.get_children():
			c.queue_free()
	for s in data:
		var new_slot = SUBSCRIPTION_BOX.instantiate()
		new_slot.data = s
		vbox.add_child(new_slot)
		new_slot.subbed.connect(_on_subbed)
		
	


func _on_subbed():
	kaching_sound.play()
	hide()
	subs_label.get_parent().hide()
	Hud.timer.start_timer()
	PlayerManager.player_exit_cutscene()
