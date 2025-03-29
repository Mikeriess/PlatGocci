extends Node

# This script can be attached to a node to handle sprite sheet animations
# for more complex plant animations than just basic scaling

export(Texture) var sprite_sheet
export(Vector2) var frame_dimensions = Vector2(64, 64)
export(int) var frames_per_row = 4
export(float) var frame_duration = 0.1

var current_frame = 0
var total_frames = 0
var rows = 0
var columns = 0
var timer = 0
var playing = true

# The texture rect to update with the current frame
var target_texture_rect: TextureRect

func _ready():
	if sprite_sheet:
		setup_sprite_sheet()
	
	# Find the texture rect to update
	target_texture_rect = get_parent().get_node("TextureRect")
	if not target_texture_rect:
		printerr("SpriteSheetAnimator: No TextureRect found as child of parent node")

func setup_sprite_sheet():
	# Calculate the number of columns and rows in the sprite sheet
	columns = frames_per_row
	var sheet_size = sprite_sheet.get_size()
	rows = int(sheet_size.y / frame_dimensions.y)
	total_frames = rows * columns
	
	# Set the initial frame
	update_frame(0)

func _process(delta):
	if playing and sprite_sheet and target_texture_rect:
		timer += delta
		if timer >= frame_duration:
			timer = 0
			current_frame = (current_frame + 1) % total_frames
			update_frame(current_frame)

func update_frame(frame_number):
	if not sprite_sheet or not target_texture_rect:
		return
		
	# Calculate the position of the frame in the sprite sheet
	var row = frame_number / columns
	var column = frame_number % columns
	
	# Create a new AtlasTexture for the frame
	var atlas = AtlasTexture.new()
	atlas.atlas = sprite_sheet
	atlas.region = Rect2(column * frame_dimensions.x, row * frame_dimensions.y, 
						frame_dimensions.x, frame_dimensions.y)
	
	# Update the texture rect
	target_texture_rect.texture = atlas

func play():
	playing = true

func stop():
	playing = false

func set_frame(frame_number):
	current_frame = frame_number % total_frames
	update_frame(current_frame) 