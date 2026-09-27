extends ScrollContainer
const SUBSCRIPTION_BOX = preload("uid://0ha7moh00yed")

var max_size: int = 3
var data: Array[Subscription]
@onready var vbox: VBoxContainer = $VBoxContainer

func _ready() -> void:
	hide()
	create_shop_data()

func open_shop():
	create_shop_data()
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
	hide()
	Hud.timer.timer.start()
	PlayerManager.player_exit_cutscene()
