extends ScrollContainer
const SUBSCRIPTION_BOX = preload("uid://0ha7moh00yed")

var max_size: int = 100
var data: Array[Subscription]
@onready var v_box_container: VBoxContainer = $VBoxContainer

func _ready() -> void:
	hide()
	create_shop_data()

func open_shop():
	show()

func create_shop_data():
	var data_array: Array[Subscription]
	for file_name in DirAccess.get_files_at("res://subscriptions/"):
		if (file_name.get_extension() == "remap"):
			file_name = file_name.replace('.remap', '')
		file_name = "res://subscriptions/"+file_name
		
		data_array.append(load(file_name))
	
	print(data_array)
	if max_size > 0 and data_array.size() > max_size:
		data_array.resize(max_size)
	data = data_array
	update_inventory()

func update_inventory() -> void:
	for s in data:
		var new_slot = SUBSCRIPTION_BOX.instantiate()
		new_slot.data = s
		v_box_container.add_child(new_slot)
		new_slot.subbed.connect(_on_subbed)
		
	


func _on_subbed():
	hide()
	Hud.timer.timer.start()
	PlayerManager.player_exit_cutscene()
