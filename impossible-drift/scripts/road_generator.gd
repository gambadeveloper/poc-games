extends Node2D

class_name RoadGenerator

@export var track_width := 200.0
@export var oval_width := 800.0
@export var oval_height := 1200.0

var track_path: Path2D
var track_visual: Line2D

func _ready():
	create_oval_track()

func create_oval_track():
	track_path = Path2D.new()
	var curve = Curve2D.new()
	
	var points = 32
	for i in range(points + 1):
		var angle = (float(i) / points) * TAU
		var x = cos(angle) * oval_width
		var y = sin(angle) * oval_height
		curve.add_point(Vector2(x, y))
	
	track_path.curve = curve
	add_child(track_path)
	
	var asphalt_texture = load("res://sprites/asphalt.jfif")
	
	track_visual = Line2D.new()
	track_visual.width = track_width
	track_visual.texture = asphalt_texture
	track_visual.texture_mode = Line2D.LINE_TEXTURE_TILE
	track_visual.default_color = Color.WHITE
	track_visual.points = curve.get_baked_points()
	track_visual.closed = true
	add_child(track_visual)

func update_road(player_y_pos, difficulty):
	pass
