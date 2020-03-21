extends PropertyEdit


func set_value(new_value):
	$ColorPickerButton.color = new_value

func _on_ColorPickerButton_color_changed(color):
	emit_signal("edited", color)
