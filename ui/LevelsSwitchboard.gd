extends Control

func _ready():
	GameState.set_responsiveness(GameState.Responsiveness.EXPAND)

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
