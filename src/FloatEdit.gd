extends PropertyEdit

func set_value(new_value):
	$HSlider.value = new_value

func _on_HSlider_value_changed(value):
	emit_signal("edited", value)
