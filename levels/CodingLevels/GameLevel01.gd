extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$BlueCoding01.spawn_balloon('green', Vector2(160, -500), 'Hello Kind Man')


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
