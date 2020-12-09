extends "res://levels/CodingLevels/Levels/HttpReqShared.gd"

export (GDScript) var coding_resources_object
export (Theme) var interactive_session_theme
export (Theme) var output_panel_theme

onready var coding_ground = $CanvasLayer/InteractiveSession/Full/Right/Top/CodingGround
onready var debug_output = $CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Build/OutputMargin/Output
onready var slides = $CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Slides/SlidesMargin/Slide
onready var slideCountLabel =$CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Slides/Count/CountLabel
onready var exercises = $CanvasLayer/InteractiveSession/Full/Right/Bottom/TabContainer/Exercise/ExerciseMargin/Exercise
onready var game_level = $BlueCoding01

var coding_resources

var currentSlide = 0
var slidesCount

func _ready():
	init($HTTPRequest)
	var error = connect("req_complete", self, "_on_req_complete")
	if error != OK:
		print_debug("Error while connecting to req_completed signal")
		
	# Fill text objects
	coding_resources = coding_resources_object.new()
	coding_ground.text = coding_resources.code
	exercises.bbcode_text = coding_resources.exercise
	
	slides.bbcode_text  = coding_resources.slides[currentSlide]
	slidesCount = coding_resources.slides.size()
	slideCountLabel.text = str(currentSlide + 1) + " of " + str(slidesCount)
	
	# Themes
	$CanvasLayer/InteractiveSession.set_theme(interactive_session_theme)
	debug_output.set_theme(output_panel_theme)
	$CanvasLayer/InteractiveSession/Alert.set_theme(output_panel_theme)
	
	# For the slides
	error = $CanvasLayer/InteractiveSession.connect("next_slide", self, "_on_next_slide")
	if error != OK:
		print_debug("Error while connecting to next_slide signal")
	error = $CanvasLayer/InteractiveSession.connect("prev_slide", self, "_on_prev_slide")
	if error != OK:
		print_debug("Error while connecting to next_slide signal")

func _on_next_slide():
	currentSlide += 1
	if currentSlide >= slidesCount:
		currentSlide = slidesCount - 1
	
	slideCountLabel.text = str(currentSlide + 1) + " of " + str(slidesCount)
	slides.bbcode_text = coding_resources.slides[currentSlide]

func _on_prev_slide():
	currentSlide -= 1
	if currentSlide <= 0:
		currentSlide = 0
	
	slideCountLabel.text = str(currentSlide + 1) + " of " + str(slidesCount)
	slides.bbcode_text = coding_resources.slides[currentSlide]

func _on_InteractiveSession_build():
	var code = _get_code_to_test()
	var test = coding_resources.tests
	var label = $CanvasLayer/InteractiveSession/Alert/HBoxContainer/Label
	var interactive_session = $CanvasLayer/InteractiveSession
	_test_code(code, test, label, interactive_session)


func _on_req_complete(build_status, result):
	debug_output.text = result
	debug_output.cursor_set_line(debug_output.get_line_count())
	$CanvasLayer/InteractiveSession.show_alert(build_status)
	_success(build_status)


func _get_code_to_test():
	var pre = """def printer():
	"""
	var post = ""
	return pre + coding_ground.text + "\n" + post
	

func _success(build_status):
	if build_status == "success":
		var player = $BlueCoding01/Player.get_child(0)
		var spawn_point = Vector2(player.position.x, rand_range(-100, -300))
		game_level.spawn_balloon('blue', spawn_point, 'Hello World!')
