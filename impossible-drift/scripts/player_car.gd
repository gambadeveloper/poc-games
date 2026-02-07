extends CharacterBody2D

signal durability_changed(value)
signal fuel_changed(value)
signal collision_occurred

@export var base_speed := 300.0
@export var max_speed := 600.0
@export var acceleration := 150.0
@export var steering_power := 3.0
@export var friction := 0.98
@export var drift_friction := 0.95

var current_speed := 0.0
var max_durability := 100.0
var durability := 100.0
var max_fuel := 100.0
var fuel := 100.0
var fuel_consumption_rate := 5.0

var speed_multiplier := 1.0
var durability_multiplier := 1.0
var fuel_multiplier := 1.0

func _ready():
	durability_changed.emit(durability / max_durability)
	fuel_changed.emit(fuel / max_fuel)
	rotation = -PI / 2

func _physics_process(delta):
	if durability <= 0:
		return
	
	var steer = 0.0
	if Input.is_action_pressed("ui_left"):
		steer = -1.0
	elif Input.is_action_pressed("ui_right"):
		steer = 1.0
	
	rotation += steer * steering_power * delta
	
	current_speed += acceleration * delta
	current_speed = clamp(current_speed, 0, max_speed * speed_multiplier)
	
	var forward = Vector2(cos(rotation), sin(rotation))
	var desired_velocity = forward * current_speed
	
	var velocity_direction = velocity.normalized()
	var forward_dot = forward.dot(velocity_direction) if velocity.length() > 0 else 1.0
	
	if abs(forward_dot) < 0.7:
		velocity = velocity.lerp(desired_velocity, drift_friction * delta * 5)
	else:
		velocity = velocity.lerp(desired_velocity, friction * delta * 10)
	
	move_and_slide()
	
func apply_steering(angle_delta):
	rotation += angle_delta * steering_power * get_physics_process_delta_time()

func handle_collision(collision):
	var damage = 10.0 / durability_multiplier
	durability -= damage
	durability = max(0, durability)
	durability_changed.emit(durability / (max_durability * durability_multiplier))
	collision_occurred.emit()
	
	velocity *= 0.5

func add_fuel(amount):
	fuel = min(fuel + amount, max_fuel * fuel_multiplier)
	fuel_changed.emit(fuel / (max_fuel * fuel_multiplier))

func upgrade_speed():
	speed_multiplier += 0.3

func upgrade_durability():
	var old_max = max_durability * durability_multiplier
	durability_multiplier += 0.5
	var new_max = max_durability * durability_multiplier
	durability += (new_max - old_max)
	durability_changed.emit(durability / new_max)

func upgrade_fuel():
	var old_max = max_fuel * fuel_multiplier
	fuel_multiplier += 0.5
	var new_max = max_fuel * fuel_multiplier
	fuel += (new_max - old_max)
	fuel_changed.emit(fuel / new_max)

func is_alive():
	return durability > 0
