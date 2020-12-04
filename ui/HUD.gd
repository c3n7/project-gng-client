extends MarginContainer

signal pause

onready var life_counter = [
	$HBoxContainer/Left/Lives/L1,
	$HBoxContainer/Left/Lives/L2,
	$HBoxContainer/Left/Lives/L3,
	$HBoxContainer/Left/Lives/L4,
	$HBoxContainer/Left/Lives/L5
]


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _on_Player_life_changed(value):
	for life in range(life_counter.size()):
		life_counter[life].visible = value > life

func _on_score_changed(value):
	$HBoxContainer/Left/ScoreLabel.text = str(value)


func _on_Pause_pressed():
	# TODO: Pause input controls
	emit_signal("pause")
	
