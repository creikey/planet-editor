extends PropertyEdit


func set_value(new_value):
	$CheckButton.pressed = new_value


func _on_CheckButton_toggled(button_pressed):
	emit_signal("edited", button_pressed)
