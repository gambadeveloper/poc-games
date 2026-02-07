extends Node2D

@export var spawn_interval := 5.0
@export var spawn_distance := 1000.0
@export var fuel_amount := 30.0

var spawn_timer := 0.0

func _process(delta):
	spawn_timer += delta
	
	if spawn_timer >= spawn_interval:
		spawn_timer = 0.0
		spawn_fuel()

func spawn_fuel():
	var fuel = Area2D.new()
	var collision = CollisionShape2D.new()
	var shape = CircleShape2D.new()
	var visual = ColorRect.new()
	
	shape.radius = 20
	visual.size = Vector2(40, 40)
	visual.color = Color(0.2, 0.8, 0.2)
	visual.position = -visual.size / 2
	
	collision.shape = shape
	fuel.add_child(visual)
	fuel.add_child(collision)
	
	fuel.position = Vector2(
		randf_range(-200, 200),
		-spawn_distance
	)
	
	fuel.set_meta("fuel_amount", fuel_amount)
	add_child(fuel)

func cleanup_fuel(player_y):
	for child in get_children():
		if child.position.y > player_y + 500:
			child.queue_free()
