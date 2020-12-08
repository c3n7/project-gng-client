extends Node

enum Responsiveness { EXPAND, SHOW_MORE}

var num_levels = 2
var current_level = 1

var title_screen = 'res://ui/HomeScreen.tscn'
var levels_screen = 'res://ui/LevelsSwitchboard.tscn'
var level1 = 'res://levels/Green/levels/GreenLevel01.tscn'

var levels = [
	'res://levels/CodingLevels/Levels/02-Variables.tscn',
	'res://levels/Red/levels/RedLevel01.tscn',
	'res://levels/CodingLevels/Levels/01-HelloWorld.tscn',
	'res://levels/Yellow/levels/YellowLevel01.tscn'
]

func restart():
	var error = get_tree().change_scene(title_screen)
	if error != OK:
		push_error("Error while changing scene")

func next_level():
	var error = get_tree().change_scene(level1)
	if error != OK:
		push_error("Error while changing scene")

func open_level(i):
	if i > levels.size():
		return
	var error = get_tree().change_scene(levels[i - 1])
	if error != OK:
		push_error("Error while changing scene")

func open_levels_screen():
	var error = get_tree().change_scene(levels_screen)
	if error != OK:
		push_error("Error while changing scene")

func open_title_screen():
	var error = get_tree().change_scene(title_screen)
	if error != OK:
		push_error("Error while changing scene")

func set_responsiveness(type):
	if type == Responsiveness.EXPAND:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(960, 480))
	elif type == Responsiveness.SHOW_MORE:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_KEEP, Vector2(640, 480))
