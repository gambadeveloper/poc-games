extends CanvasLayer

signal upgrade_selected(type)

@onready var panel = $Panel

func _ready():
	hide()

func show_upgrades():
	panel.show()
	get_tree().paused = true

func hide_upgrades():
	panel.hide()
	get_tree().paused = false

func _on_speed_button_pressed():
	upgrade_selected.emit("speed")
	hide_upgrades()

func _on_durability_button_pressed():
	upgrade_selected.emit("durability")
	hide_upgrades()

func _on_fuel_button_pressed():
	upgrade_selected.emit("fuel")
	hide_upgrades()
