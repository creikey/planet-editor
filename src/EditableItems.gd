extends VBoxContainer

export (NodePath) var planet_path

onready var generator = get_node(planet_path).generator

func _ready():
	for setting in generator.settings.keys():
		var type_and_value: Array = generator.settings[setting]
		var cur_editable: PropertyEdit = null
		match type_and_value[0]:
			"float":
				cur_editable = preload("res://FloatEdit.tscn").instance()
			"color":
				cur_editable = preload("res://ColorEdit.tscn").instance()
			"int":
				cur_editable = preload("res://IntEdit.tscn").instance()
			"noise_settings":
				cur_editable = preload("res://NoiseEdit.tscn").instance()
			"vec2":
				cur_editable = preload("res://Vec2Edit.tscn").instance()
			"bool":
				cur_editable = preload("res://BoolEdit.tscn").instance()
			"image":
				cur_editable = preload("res://ImageEdit.tscn").instance()
		if cur_editable != null:
			add_child(cur_editable)
			cur_editable.connect("edited", self, "_on_edit", [setting])
			cur_editable.name = setting
			cur_editable.text = setting
			cur_editable.value = type_and_value[1]
			cur_editable.update_text()
		else:
			printerr("Unknown editable setting:type: ", setting, ":", type_and_value[0])

func update_gui_from_settings():
	for gui_node in get_children():
		if gui_node.name == "ColorEdit":
			continue
		gui_node.value = generator.settings[gui_node.name][1]

func get_json_text() -> String:
	return to_json(generator.settings)

func set_from_json_text(text: String):
	generator.settings = parse_json(text)
	generator.apply_settings()

func _on_edit(new_value, setting_name):
	generator.settings[setting_name][1] = new_value
	generator.apply_settings()
