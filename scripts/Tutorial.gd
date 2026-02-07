extends Node2D

func _ready() -> void:
	pass


func _on_start_button_pressed() -> void:
	AudioManager.playUIClick()
	SceneSwitcher.switch_scene("uid://blun7ob78f403")
