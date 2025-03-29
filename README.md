# PlantGocci

This is a MVP version of a Godot-based game that has an animated plant on the desktop, running in the background, and nothing else.

## Setup Instructions

1. Install Godot Engine (3.x) from [godotengine.org](https://godotengine.org)
2. Open the project by importing the project.godot file
3. Place your plant animation images in the `graphics/` folder
   - Create a "plant_placeholder.png" file or update the Main.tscn to point to your image
4. Run the project (F5 or Play button)

## Features

- Transparent window that stays on top of other windows
- Draggable plant (click and drag)
- Right-click menu to change animations or exit
- Low CPU usage with idle optimization

## Project Structure

- `project.godot` - Main project file
- `src/scenes/` - Contains the TSCN scene files
- `src/scripts/` - Contains GDScript files
- `graphics/` - Place your plant animation images here

## Customization

To customize animations, you can:
1. Edit the AnimationPlayer in the Main scene
2. Add more animation tracks for complex movements
3. Replace with an AnimatedSprite for frame-by-frame animation 