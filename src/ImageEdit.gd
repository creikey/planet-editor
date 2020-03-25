extends PropertyEdit

var my_image_texture: ImageTexture = null

var mesh_is_img_texture := false # tracks if the mesh has been set to an image texture

func set_value(new_value): # value is sometimes a viewport node
	if new_value is Viewport:
		mesh_is_img_texture = false
		value = new_value
		$ActiveButton.pressed = false
	elif new_value is Dictionary:
		# not a viewport, image data, set to pressed state
		mesh_is_img_texture = true
		$ActiveButton.pressed = true
		
		# cache given data to path
		var image := Image.new()
		image.data = new_value
		image.save_png(_get_temp_image_path())
	else:
		# image data from loaded file is wrong
		printerr("Unknown value in ImageEdit: ", new_value)

func _ready():
	get_node("/root/Main").connect("reload_from_aseprite", self, "_on_reload")

func _on_reload():
	if not $ActiveButton.pressed: # only load if planet is replaced with image right now 
		return
	emit_signal("edited", _load_data_from_path())

func _load_data_from_path() -> Dictionary:
	var image := Image.new()
	image.load(_get_temp_image_path())
	return image.data

#func _create_image_texture() -> ImageTexture:
#	var texture := ImageTexture.new()
#	var image := Image.new()
#	image.load(_get_temp_image_path())
#	texture.create_from_image(image)
#	texture.flags = 2
#	return texture

func _get_temp_image_path() -> String:
	return "user://" + $Label.text + ".png"

func _on_ActiveButton_toggled(button_pressed: bool):
	if button_pressed:
		# if this is null then set_value was never called with the viewport
		if mesh_is_img_texture: # already an image, don't need to copy from viewport
			return
		# copy image from viewport and save
		var viewport_image: Image = value.get_texture().get_data()
		viewport_image.save_png(_get_temp_image_path())
		emit_signal("edited", viewport_image.data)
	else:
		emit_signal("edited", value) # change dict entry back to viewport

func _on_OpenInAsepriteButton_pressed():
	if not $ActiveButton.pressed:
		return
	var aseprite_path: String = ""
	if OS.get_name() == "X11":
		aseprite_path = "/home/creikey/Documents/other/aseprite/build/bin/aseprite"
	elif OS.get_name() == "Windows":
		aseprite_path = "C:/Program Files (x86)/Steam/steamapps/common/Aseprite/Aseprite.exe"
	OS.execute(aseprite_path, PoolStringArray([OS.get_user_data_dir().plus_file(_get_temp_image_path().get_file())]), false)
