extends Control

class_name PropertyEdit

signal edited(new_value)

export var text: String = ""

var value setget set_value

func _ready():
	update_text()

func set_value(new_value):
	value = new_value

func update_text():
	$Label.text = text
