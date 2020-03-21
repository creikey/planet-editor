extends PropertyEdit

var my_value := Vector2()

func set_value(new_value):
	my_value = new_value
	$VBoxContainer/XSlider.value = my_value.x
	$VBoxContainer/YSlider.value = my_value.y

func _on_XSlider_value_changed(value):
	my_value.x = value
	emit_signal("edited", my_value)

func _on_YSlider_value_changed(value):
	my_value.y = value
	emit_signal("edited", my_value)
