extends Control

signal steering_changed(angle_delta)

@export var max_rotation := 45.0
@export var return_speed := 5.0

var is_touching := false
var touch_start_pos := Vector2.ZERO
var current_rotation := 0.0

@onready var wheel_sprite = $WheelSprite

func _ready():
	wheel_sprite.rotation = 0

func _input(event):
	if event is InputEventScreenTouch:
		if event.pressed and get_global_rect().has_point(event.position):
			is_touching = true
			touch_start_pos = event.position
		else:
			is_touching = false
	
	elif event is InputEventScreenDrag and is_touching:
		var delta_x = event.position.x - touch_start_pos.x
		current_rotation = clamp(delta_x / 100.0, -1.0, 1.0)
		touch_start_pos = event.position

func _process(delta):
	if not is_touching:
		current_rotation = lerp(current_rotation, 0.0, return_speed * delta)
	
	var target_angle = current_rotation * deg_to_rad(max_rotation)
	wheel_sprite.rotation = target_angle
	
	steering_changed.emit(current_rotation)
