extends Control

var  blue = preload("res://ui/levelButtons/blue.tscn")
var red = preload("res://ui/levelButtons/red.tscn")
var green = preload("res://ui/levelButtons/green.tscn")
var yellow = preload("res://ui/levelButtons/yellow.tscn")
var locked = preload("res://ui/levelButtons/locked.tscn")
var divider = preload("res://ui/levelButtons/divider.tscn")
onready var buttons = $MarginContainer/Panel/CenterContainer/VBoxContainer/CenterContainer/ScrollContainer/CenterContainer/HBoxContainer

# 1 Hello World
# 2 Variables
# 3 Math Operators
# 4 Functions
# 5 Assignment Operators

var levels = {
	"1\nHello\nWorld": "blue",
	"2\nVariables": "yellow",
	"3\nMath\nOperators": "red",
	"4\nFunctions": "green",
	"5\nAssignment\nOperators": "blue"
}

var required_score = [
	0,
	10,
	20,
	30,
	40
]

func _ready():
	GameState.set_responsiveness(GameState.Responsiveness.EXPAND)
	var score = GameState.get_score()
	
	var i = 1
	for key in levels:
		var b
		if score < required_score[i-1]:
			b = locked.instance()
		else:
			match levels[key]:
				"blue":
					b = blue.instance()
				"red":
					b = red.instance()
				"green":
					b = green.instance()
				"yellow":
					b = yellow.instance()

		if score < required_score[i - 1]:
			var text = "\nUNLOCK\nWITH SCORE OF\n" + str(required_score[i - 1])
			b.init(text)
		else:
			b.init(key)
		var error = b.connect("clicked", self, "_on_L" + str(i) + "_Button_pressed")
		if error != OK:
			print_debug("Error while connecting signal")
		i = i + 1
		
		buttons.add_child(b)
		var d = divider.instance()
		buttons.add_child(d)


func _on_BackButton_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_title_screen()

func _on_L1_Button_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_level(1)

func _on_L2_Button_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_level(2)

func _on_L3_Button_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_level(3)

func _on_L4_Button_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_level(4)


func _on_L5_Button_pressed():
	$Click.play()
	yield($Click, "finished")
	GameState.open_level(5)
