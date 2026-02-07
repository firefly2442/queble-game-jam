extends Node2D

func _ready() -> void:
	pass


func _on_back_button_pressed() -> void:
	AudioManager.playUIClick()
	SceneSwitcher.switch_scene("uid://jhs55aqbv7tw")
