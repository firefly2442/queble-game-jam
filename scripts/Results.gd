extends Node2D

func _ready() -> void:
	(%PeopleSaved as Label).text = str(GameState.people_delivered)
	(%PeopleEaten as Label).text = str(GameState.people_eaten)
	(%FinalScore as Label).text = str(GameState.people_delivered - GameState.people_eaten)


func _on_continue_button_pressed() -> void:
	GameState.reset()
	AudioManager.playUIClick()
	# back to main menu
	SceneSwitcher.switch_scene("uid://jhs55aqbv7tw")
