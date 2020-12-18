extends Node

enum Responsiveness { EXPAND, SHOW_MORE}

var num_levels = 2
var current_level = 1

var title_screen = 'res://ui/HomeScreen.tscn'
var levels_screen = 'res://ui/LevelsSwitchboard.tscn'
var user_screen = 'res://ui/UserScreen.tscn'

var levels = [
	'res://levels/CodingLevels/Levels/01-HelloWorld.tscn',
	'res://levels/CodingLevels/Levels/02-Variables.tscn',
	'res://levels/CodingLevels/Levels/03-Operators.tscn',
	'res://levels/CodingLevels/Levels/04-Functions.tscn',
	'res://levels/CodingLevels/Levels/05-AssignmentOperators.tscn'
]

var level1 = levels[0]

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
		push_warning("Attempting to fetch unadded level")
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

func open_user_screen():
	var error = get_tree().change_scene(user_screen)
	if error != OK:
		push_error("Error while changing scene")

func set_responsiveness(type):
	if type == Responsiveness.EXPAND:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_2D, SceneTree.STRETCH_ASPECT_EXPAND, Vector2(960, 480))
	elif type == Responsiveness.SHOW_MORE:
		get_tree().set_screen_stretch(SceneTree.STRETCH_MODE_DISABLED, SceneTree.STRETCH_ASPECT_KEEP, Vector2(640, 480))


var score_file = "user://project-gng-data.json"

func add_score(score):
	var records = get_records_dict()
	var current_score
	if records.empty() or not records.has("score"):
		current_score = 0
	else:
		current_score = records["score"]
	var new_score = current_score + score
	# HACK: using this to reset score
	if score <= 0:
		new_score = 0
	records["score"] = new_score
	store_records_dict(records)

func store_records_dict(records):
	var f = File.new()
	f.open(score_file, File.WRITE)
	f.store_string(JSON.print(records))
	f.close()

func get_records_dict():
	var recordsDict: Dictionary = {}
	var f = File.new()
	if f.file_exists(score_file):
		f.open(score_file, File.READ)
		recordsDict = JSON.parse(f.get_as_text()).result
	return recordsDict

func get_score():
	var records = get_records_dict()
	var current_score
	if records.empty() or not records.has("score"):
		current_score = 0
	else:
		current_score = records["score"]
	return current_score

func get_user():
	var current_user
	var records = get_records_dict()
	if records.empty() or not records.has("user"):
		current_user = ""
	else:
		current_user = records["user"]
	return current_user

func set_user(user):
	var records = get_records_dict()
	records["user"] = user
	store_records_dict(records)
