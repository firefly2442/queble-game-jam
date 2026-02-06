class_name Person
extends Node2D

var starting_city: City ## the city the person is starting from
var ending_city: City ## the city the person is moving towards
var number_people: int
var road: Road ## the road the person is on
@export var speed: float = 40
var segment_index: int = 0
var segment_t: float = 0.0
var increasing_segment_index: bool = true

func _ready() -> void:
	self.add_to_group("person")

func hasMoreSegments() -> bool:
	return (increasing_segment_index and segment_index < road.points.size() - 1) \
		or (not increasing_segment_index and segment_index > 0)

func _process(delta: float) -> void:
	(%PersonLabel as Label).text = str(number_people)
	if not road:
		road = Utility.getRoadFromCities(starting_city, ending_city)
		if road.start_city == starting_city:
			segment_index = 0
			increasing_segment_index = true
		else:
			segment_index = road.road_segments - 1
			increasing_segment_index = false
		segment_t = 0.0

	if not starting_city or not ending_city or not road:
		return

	var distance_left: float = speed * delta

	if global_position.distance_to(ending_city.city_position) < 0.5:
		GameState.people_delivered += number_people
		queue_free()
		return

	var dir: int = 1 if increasing_segment_index else -1

	while distance_left > 0.0 and hasMoreSegments():
		var from: Vector2 = road.points[segment_index]
		var to: Vector2 = road.points[segment_index + dir]
		var segment_length: float = from.distance_to(to)

		var snow: float = road.snow_amount[segment_index]
		var minimum_speed: float = 0.4
		var speed_factor: float = lerp(1.0, minimum_speed, snow)

		var effective_distance: float = distance_left * speed_factor
		var remaining: float = segment_length - segment_t

		if effective_distance < remaining:
			segment_t += effective_distance
			global_position = from.lerp(to, segment_t / segment_length)
			distance_left = 0.0
		else:
			global_position = to
			segment_t = 0.0
			segment_index += dir
			distance_left -= remaining / speed_factor

func setNumberOfPeople(n: int) -> void:
	number_people = n


func _on_area_2d_area_entered(area: Area2D) -> void:
	var collider: Node2D = area.get_parent()
	if collider.is_in_group("dragon"):
		GameState.people_delivered -= self.number_people
		self.queue_free()
