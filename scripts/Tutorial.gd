extends Node2D

func _ready() -> void:
	pass

func _on_easy_start_button_pressed() -> void:
	GameState.number_dragons = 1
	AudioManager.playUIClick()
	SceneSwitcher.switch_scene("uid://blun7ob78f403")


func _on_medium_start_button_pressed() -> void:
	GameState.number_dragons = 2
	AudioManager.playUIClick()
	SceneSwitcher.switch_scene("uid://blun7ob78f403")


func _on_hard_start_button_pressed() -> void:
	GameState.number_dragons = 3
	AudioManager.playUIClick()
	SceneSwitcher.switch_scene("uid://blun7ob78f403")
