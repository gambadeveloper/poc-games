extends Node2D

signal obstacle_spawned

@export var spawn_interval := 2.0
@export var spawn_distance := 1000.0

var obstacle_scenes := {}
var spawn_timer := 0.0
var difficulty := 0.0

func _process(delta):
	spawn_timer += delta
	
	var adjusted_interval = spawn_interval / (1.0 + difficulty * 0.5)
	
	if spawn_timer >= adjusted_interval:
		spawn_timer = 0.0
		spawn_random_obstacle()

func spawn_random_obstacle():
	var obstacle_type = randi() % 3
	var obstacle = create_obstacle(obstacle_type)
	
	obstacle.position = Vector2(
		randf_range(-250, 250),
		-spawn_distance
	)
	
	add_child(obstacle)
	obstacle_spawned.emit()

func create_obstacle(type):
	var obstacle = Area2D.new()
	var collision = CollisionShape2D.new()
	var shape = RectangleShape2D.new()
	var visual = ColorRect.new()
	
	match type:
		0:  # AI Car
			shape.size = Vector2(40, 70)
			visual.size = Vector2(40, 70)
			visual.color = Color(0.8, 0.2, 0.2)
		1:  # Debris
			shape.size = Vector2(30, 30)
			visual.size = Vector2(30, 30)
			visual.color = Color(0.5, 0.4, 0.3)
		2:  # Hole
			shape.size = Vector2(50, 50)
			visual.size = Vector2(50, 50)
			visual.color = Color(0.1, 0.1, 0.1)
	
	visual.position = -visual.size / 2
	collision.shape = shape
	
	obstacle.add_child(visual)
	obstacle.add_child(collision)
	
	return obstacle

func update_difficulty(dist):
	difficulty = dist / 1000.0

func cleanup_obstacles(player_y):
	for child in get_children():
		if child.position.y > player_y + 500:
			child.queue_free()
