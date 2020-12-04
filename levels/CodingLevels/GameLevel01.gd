extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var spawn_point = Vector2(160, -500)

# Called when the node enters the scene tree for the first time.
func _ready():
	$BlueCoding01.spawn_balloon('green', spawn_point, 'Hello Kind Man')


func _on_InteractiveSession_show_balloon(quantity):
	$BlueCoding01.spawn_balloon('blue', spawn_point, 'Voila')
