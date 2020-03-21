extends PropertyEdit

func set_value(new_value):
	$LineEdit.text = str(new_value)

func _on_LineEdit_text_changed(new_text: String):
	var text_as_int := int(new_text)
	emit_signal("edited", text_as_int)
	$LineEdit.text = str(text_as_int)
