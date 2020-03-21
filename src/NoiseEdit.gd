extends PropertyEdit

var values = [0, 0.0, 0.0, 0.0]

func set_value(new_values):
	values = new_values
	$OctavesEdit.text = str(values[0])
	$BigFloatVal.value = values[1]
	$SmallFloatVal1.value = values[2]
	$SmallFloatVal2.value = values[3]

func _on_OctavesEdit_text_changed(new_text):
	var as_int := int(new_text)
	values[0] = as_int
	$OctavesEdit.text = str(as_int)
	emit_signal("edited", values)

func _on_BigFloatVal_value_changed(value):
	values[1] = value
	emit_signal("edited", values)

func _on_SmallFloatVal1_value_changed(value):
	values[2] = value
	emit_signal("edited", values)

func _on_SmallFloatVal2_value_changed(value):
	values[3] = value
	emit_signal("edited", values)
