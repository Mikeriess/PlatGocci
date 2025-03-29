extends Control

var dragging = false
var drag_start_position = Vector2()
var window_start_position = Vector2()

func _ready():
	# Connect the input signals
	connect("gui_input", self, "_on_gui_input")

func _on_gui_input(event):
	# Handle mouse events for dragging
	if event is InputEventMouseButton:
		if event.button_index == BUTTON_LEFT:
			if event.pressed:
				# Start dragging
				dragging = true
				drag_start_position = event.global_position
				window_start_position = OS.window_position
			else:
				# Stop dragging
				dragging = false
	
	# Handle mouse motion for dragging
	elif event is InputEventMouseMotion and dragging:
		# Calculate new window position
		var new_position = window_start_position + (event.global_position - drag_start_position)
		OS.window_position = new_position 