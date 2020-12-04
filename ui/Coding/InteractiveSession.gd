extends Control

signal show_balloon(quantity)
signal build

onready var coding_ground = $Full/Right/Top/CodingGround

var keywords = [
	"False", "await", "else", "import", "pass",
	"None", "break", "except", "in", "raise",
	"True", "class", "finally", "is", "return",
	"and", "continue", "for", "lambda", "try",
	"as", "def", "from", "nonlocal", "while",
	"assert", "del", "global", "not", "with",
	"async", "elif", "if", "or", "yield"]


# Called when the node enters the scene tree for the first time.
func _ready():
	for keyword in keywords:
		coding_ground.add_color_region("#", '', Color("#686868"))
		coding_ground.add_keyword_color(keyword, Color("#fba922"))


func _on_Build_pressed():
	# TODO: Remove this line
	emit_signal("show_balloon", 1)
	emit_signal("build")

func show_alert(image):
	if $Alert/AnimationPlayer.is_playing():
		# If animation is already playing, wait first
		yield($Alert/AnimationPlayer, "animation_finished")
	
	# HACK: Add padding better
	var labelText = ""
	match image:
		"success":
			$Alert/Panel/Building.hide()
			$Alert/Panel/Failure.hide()
			$Alert/Panel/Success.show()
			labelText = "   Success"
		"failed":
			$Alert/Panel/Building.hide()
			$Alert/Panel/Failure.show()
			$Alert/Panel/Success.hide()
			labelText = "   Failed"
		# TODO: Show help button
		"error":
			$Alert/Panel/Building.hide()
			$Alert/Panel/Failure.show()
			$Alert/Panel/Success.hide()
			labelText = "   Error"
		"building":
			$Alert/Panel/Building.show()
			$Alert/Panel/Failure.hide()
			$Alert/Panel/Success.hide()
			labelText = "   Building"
	
	$Alert/HBoxContainer/Label.text = labelText
	$Alert/AnimationPlayer.play("slide_in_out")
	$Whoosh.play()
