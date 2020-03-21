extends Node2D

onready var spacer: Control = get_node("UI/MainEditor/Spacer")

export (NodePath) var editable_items_path

onready var editable_items = get_node(editable_items_path)
onready var file_dialog: FileDialog = $UI/FileDialog

var saving := false

func _ready():
	file_dialog.add_filter("*.planet ; Planet files")

func _process(delta):
	$Planet.position = spacer.rect_position + spacer.rect_size/2.0


func _on_ColorEdit_edited(new_value):
	$Background/ColorRect.color = new_value


func _on_SaveButton_pressed():
#	file_dialog.filename = "cur_planet.json"
	saving = true
	file_dialog.mode = FileDialog.MODE_SAVE_FILE
	file_dialog.popup_centered_ratio(0.5)

func _on_LoadButton_pressed():
#	file_dialog.filename = "cur_planet.json"
	saving = false
	file_dialog.mode = FileDialog.MODE_OPEN_FILE
	file_dialog.popup_centered_ratio(0.5)

func _on_FileDialog_file_selected(path):
	var cur_file: File = File.new()
	if saving:
		cur_file.open(path, File.WRITE)
		cur_file.store_var(editable_items.generator.settings)
#		cur_file.store_string(editable_items.get_json_text())
	else:
		cur_file.open(path, File.READ)
		editable_items.generator.settings = cur_file.get_var()
		editable_items.generator.apply_settings()
#		editable_items.set_from_json_text(cur_file.get_as_text())
	cur_file.close()
