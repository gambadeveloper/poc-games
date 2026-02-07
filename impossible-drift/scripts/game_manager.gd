extends Node

@export var upgrade_interval := 500.0

var distance := 0.0
var time := 0.0
var next_upgrade_distance := 500.0
var best_distance := 0.0
var best_time := 0.0

@onready var player = $Player
@onready var camera = $Camera2D
@onready var road = $Road
@onready var obstacles = $ObstacleSpawner
@onready var fuel_spawner = $FuelSpawner
@onready var hud = $HUD
@onready var upgrade_menu = $UpgradeMenu
@onready var steering_wheel = $HUD/SteeringWheel

var is_game_over := false

func _ready():
	player.durability_changed.connect(hud.update_durability)
	player.fuel_changed.connect(hud.update_fuel)
	upgrade_menu.upgrade_selected.connect(_on_upgrade_selected)
	steering_wheel.steering_changed.connect(_on_steering_changed)

func _process(delta):
	if is_game_over:
		return
	
	if not player.is_alive():
		game_over()
		return
	
	time += delta
	distance += player.current_speed * delta / 100.0
	
	hud.update_distance(distance)
	hud.update_time(time)
	
	camera.position = player.position
	
	check_fuel_pickups()
	
	if distance >= next_upgrade_distance:
		next_upgrade_distance += upgrade_interval
		upgrade_menu.show_upgrades()

func _on_steering_changed(angle):
	player.apply_steering(angle)

func check_fuel_pickups():
	for fuel in fuel_spawner.get_children():
		if fuel is Area2D:
			var dist = player.global_position.distance_to(fuel.global_position)
			if dist < 50:
				player.add_fuel(fuel.get_meta("fuel_amount"))
				fuel.queue_free()

func _on_upgrade_selected(type):
	match type:
		"speed":
			player.upgrade_speed()
		"durability":
			player.upgrade_durability()
		"fuel":
			player.upgrade_fuel()

func game_over():
	is_game_over = true
	best_distance = max(best_distance, distance)
	best_time = max(best_time, time)
	print("Game Over! Distance: ", distance, " Time: ", time)
