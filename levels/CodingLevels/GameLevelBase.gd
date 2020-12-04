extends Node2D

export (GDScript) var coding_resources

func _ready():
	var c = coding_resources.new()
	$CanvasLayer/InteractiveSession/Full/Right/Top/CodingGround.text = c.code
	$CanvasLayer/InteractiveSession/Full/Right/Top/CodingGround.text = c.code
	$CanvasLayer/InteractiveSession.tests = c.tests

func _on_InteractiveSession_show_balloon(quantity):
	for _i in range(quantity):
		var player = $BlueCoding01/Player.get_child(0)
		var spawn_point = Vector2(player.position.x, rand_range(-100, -1000))
		$BlueCoding01.spawn_balloon('blue', spawn_point, 'Voila')
