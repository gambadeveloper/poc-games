# Impossible Drift - Godot 4.x

## Setup
1. Open Godot 4.x
2. Import this project
3. Run `scenes/main.tscn`

## Controls
- Touch and drag the steering wheel at the bottom to steer
- Car accelerates automatically
- Avoid obstacles and collect fuel
- Choose upgrades every 500m

## Game Systems
- **Player Car**: Automatic acceleration with drift physics
- **Steering Wheel**: Touch-based virtual steering control
- **Road Generator**: Infinite procedural road with increasing curves
- **Obstacles**: AI cars, debris, and holes that damage your vehicle
- **Fuel System**: Collect green fuel pickups to keep driving
- **Upgrades**: Choose between Speed, Durability, or Fuel upgrades every 500m
- **HUD**: Displays distance, time, fuel, and durability

## File Structure
```
scripts/
  - game_manager.gd (main game loop)
  - player_car.gd (car physics and upgrades)
  - steering_wheel.gd (touch controls)
  - road_generator.gd (infinite road)
  - obstacle_spawner.gd (spawns hazards)
  - fuel_spawner.gd (spawns fuel pickups)
  - hud.gd (UI display)
  - upgrade_menu.gd (upgrade selection)
scenes/
  - main.tscn (main game scene)
```

## Customization
Edit export variables in scripts to adjust:
- Speed, acceleration, drift behavior
- Spawn rates and difficulty scaling
- Fuel consumption and capacity
- Upgrade values
