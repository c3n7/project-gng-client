extends RigidBody2D

signal pickup

func init(type, pos, text):
	$Sprite.texture = load(textures[type])
	position = pos
	$Text.text = text

var textures = {
	'blue': 'res://assets/PNG/Items/balloonBlue.png',
	'green': 'res://assets/PNG/Items/balloonGreen.png',
	'red': 'res://assets/PNG/Items/balloonRed.png',
	'yellow': 'res://assets/PNG/Items/balloonYellow.png'
}


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):
		emit_signal('pickup')
		queue_free()
