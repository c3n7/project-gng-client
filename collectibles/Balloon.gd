extends RigidBody2D

signal pickup
signal final_balloon_picked
var final_balloon = false

func init(type, pos, text, finalBalloon=false):
	$Sprite.texture = load(textures[type])
	position = pos
	$Text.text = text
	final_balloon = finalBalloon

var textures = {
	'blue': 'res://assets/PNG/Items/balloonBlue.png',
	'green': 'res://assets/PNG/Items/balloonGreen.png',
	'red': 'res://assets/PNG/Items/balloonRed.png',
	'yellow': 'res://assets/PNG/Items/balloonYellow.png'
}


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal('pickup')
		if final_balloon:
			emit_signal("final_balloon_picked")
		queue_free()
