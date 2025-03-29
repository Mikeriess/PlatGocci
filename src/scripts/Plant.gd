extends Node2D

# Variables for controlling animation
var animations = []
var current_animation_index = 0
var animation_player
var texture_rect

func _ready():
	# Set the window to be transparent
	get_viewport().transparent_bg = true
	
	# Initialize animation player and texture rect
	animation_player = $AnimationPlayer
	texture_rect = $TextureRect
	
	# Get all animation names
	if animation_player != null:
		animations = animation_player.get_animation_list()
		if animations.size() > 0:
			animation_player.play(animations[current_animation_index])
	
	# Make window draggable
	OS.set_window_mouse_passthrough($TransparentArea.get_children())

func _input(event):
	# Check for right-click to show context menu
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_RIGHT and event.pressed:
			show_context_menu()

func show_context_menu():
	# Create popup menu
	var popup = PopupMenu.new()
	add_child(popup)
	
	# Add menu items
	popup.add_item("Next Animation", 0)
	popup.add_item("Exit", 1)
	
	# Connect signals
	popup.connect("id_pressed", self, "_on_popup_id_pressed")
	
	# Show popup at mouse position
	popup.popup(Rect2(get_global_mouse_position(), Vector2(100, 50)))

func _on_popup_id_pressed(id):
	match id:
		0:  # Next Animation
			cycle_animation()
		1:  # Exit
			get_tree().quit()

func cycle_animation():
	if animations.size() > 0:
		current_animation_index = (current_animation_index + 1) % animations.size()
		animation_player.play(animations[current_animation_index]) 