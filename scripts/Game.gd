extends Node2D

var number_cities: int = 6
var number_dragons: int = 2

func _ready() -> void:
	# randomly generate and place cities
	
	var positions: Array[Vector2i] = Utility.generate_positions(number_cities, 250, Vector2i(30, 30), Vector2i(1280-30, 720-30))
	
	for i in range(0, number_cities):
		var city_scene: PackedScene = load("uid://iqh6ldxrs8st")
		var city: City = city_scene.instantiate()
		city.city_position = positions[i]
		city.user_select_city.connect(_user_select_city)
		%Cities.add_child(city)

	var potential_edges: Array[Array] = []
	for i in range(%Cities.get_children().size()):
		for j in range(i + 1, %Cities.get_children().size()):
			var city_one: City = %Cities.get_children()[i]
			var city_two: City = %Cities.get_children()[j]
			potential_edges.append([city_one, city_two])
			
	potential_edges.shuffle()
	
	var roads: Array = []
	for edge: Array in potential_edges:  # sorted by distance
		var intersects: bool = false
		for road: Array in roads:
			var e1: Vector2 = edge[0].city_position
			var e2: Vector2 = edge[1].city_position
			var r1: Vector2 = road[0].city_position
			var r2: Vector2 = road[1].city_position
			if Utility.segments_intersect(e1, e2, r1, r2):
				intersects = true
				break
		if not intersects:
			roads.append(edge)
	
	for road: Array in roads:
		var road_scene: PackedScene = load("uid://bqdvxd444l7hg")
		var road_instance: Road = road_scene.instantiate()
		var city_one: City = road[0]
		var city_two: City = road[1]
		road_instance.init(city_one, city_two)
		city_one.addConnectedCity(city_two)
		city_two.addConnectedCity(city_one)
		%Roads.add_child(road_instance)
		var all_cities_have_road: bool = true
		for city: City in %Cities.get_children():
			if city.connected_cities.size() == 0:
				all_cities_have_road = false
		if all_cities_have_road:
			break
	GameState.roads = %Roads.get_children()
	GameState.cities = %Cities.get_children()
	

	# randomly generate and place roads
	#for i in range(0, number_roads):
		#var random_city_1: City
		#var random_city_2: City
		#while not random_city_1 or not random_city_2 or random_city_1 == random_city_2:
			#random_city_1 = %Cities.get_children().pick_random()
			#random_city_2 = %Cities.get_children().pick_random()
			## don't make a connection when we have an existing connection already
			#if random_city_1 in random_city_2.connected_cities or random_city_2 in random_city_1.connected_cities:
				#random_city_1 = null
				#random_city_2 = null
		#var road_scene: PackedScene = load("uid://bqdvxd444l7hg")
		#var road: Road = road_scene.instantiate()
		#road.init(random_city_1, random_city_2)
		#random_city_1.addConnectedCity(random_city_2)
		#random_city_2.addConnectedCity(random_city_1)
		#%Roads.add_child(road)
		
	# add dragons
	for i in range(number_dragons):
		var dragon_scene: PackedScene = load("uid://lh3txbxrchpu")
		var dragon: Dragon = dragon_scene.instantiate()
		# pick a random city to place it in
		var rand_city: City = %Cities.get_children().pick_random()
		dragon.starting_city = rand_city
		%Dragons.add_child(dragon)
	GameState.dragons = %Dragons.get_children()

func _user_select_city(city: City) -> void:
	GameState.selected_city = city
	city.drawBox()
	if city.number_people_waiting > 0:
		var person_scene: PackedScene = load("uid://c4nu0w2of1ome")
		var person: Person = person_scene.instantiate()
		person.global_position = city.global_position
		person.starting_city = city
		person.ending_city = city.connected_cities[0]
		person.setNumberOfPeople(city.number_people_waiting)
		city.number_people_waiting = 0
		%People.add_child(person)
	
func _process(_delta: float) -> void:
	(%Score as Label).text = str(GameState.people_delivered)
