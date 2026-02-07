extends CanvasLayer

@onready var fuel_bar = $MarginContainer/VBoxContainer/FuelBar
@onready var durability_bar = $MarginContainer/VBoxContainer/DurabilityBar
@onready var distance_label = $MarginContainer/VBoxContainer/DistanceLabel
@onready var time_label = $MarginContainer/VBoxContainer/TimeLabel

func update_fuel(value):
	fuel_bar.value = value * 100

func update_durability(value):
	durability_bar.value = value * 100

func update_distance(distance):
	distance_label.text = "Distance: %d m" % int(distance)

func update_time(time):
	var minutes = int(time) / 60
	var seconds = int(time) % 60
	time_label.text = "Time: %02d:%02d" % [minutes, seconds]
