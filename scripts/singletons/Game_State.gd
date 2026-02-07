extends Node

var snow_speed: float = 60.0

var cities: Array
var roads: Array
var dragons: Array
var people: Array

var selected_city: City

var people_delivered: int = 0
var people_eaten: int = 0

func _ready() -> void:
	pass

func reset() -> void:
	cities.clear()
	roads.clear()
	dragons.clear()
	people.clear()
	selected_city = null
	people_delivered = 0
	people_eaten = 0
