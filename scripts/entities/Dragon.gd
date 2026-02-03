class_name Dragon
extends Node2D

var starting_city: City ## the city the dragon is starting from
var ending_city: City ## the city the dragon is moving towards
var road: Road ## the road the dragon is on
@export var speed: float = 0.5
var segment_index: int = 0
var segment_t: float = 0.0

func _ready() -> void:
	self.global_position = starting_city.city_position

func _process(delta: float) -> void:
	if not ending_city:
		ending_city = starting_city.connected_cities.pick_random()
	
	if not road:
		road = Utility.getRoadFromCities(starting_city, ending_city)

	#if starting_city and ending_city and road:
		#var distance_left: float = speed * delta
#
		#while distance_left > 0 and segment_index < path.size() - 1:
			#var from: = road.points.path[segment_index]
			#var to := path[segment_index + 1]
			#var segment_length := from.distance_to(to)
#
			#var remaining := segment_length - segment_t
#
			#if distance_left < remaining:
				#segment_t += distance_left
				#global_position = from.lerp(to, segment_t / segment_length)
				#distance_left = 0
			#else:
				#distance_left -= remaining
				#segment_index += 1
				#segment_t = 0.0
				#global_position = to
