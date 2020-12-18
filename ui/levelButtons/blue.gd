extends HBoxContainer

signal clicked

func init(name):
	$Button/HBoxContainer/Label.text = name

func _ready():
	var error = $Button.connect("pressed", self, "_buttonClicked")
	if error != OK:
		print_debug("Error while connecting signal")

func _buttonClicked():
	emit_signal("clicked")
