extends CharacterBody3D

@export var rotation_speed  = 0.5
var rotation_range: float = 45
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	
	if Input.is_action_pressed("left"):
		rotation_degrees.y = clamp(rotation_degrees.y + rotation_speed, -rotation_range, rotation_range)
	if Input.is_action_pressed("right"):
		rotation_degrees.y = clamp(rotation_degrees.y - rotation_speed, -rotation_range, rotation_range)
	if Input.is_action_pressed("up"):
		rotation_degrees.x = clamp(rotation_degrees.x + rotation_speed, -rotation_range, rotation_range)
	if Input.is_action_pressed("down"):
		rotation_degrees.x = clamp(rotation_degrees.x - rotation_speed, -rotation_range, rotation_range)
		
	if Input.is_action_just_pressed("space"):
		print("fire !!!")
		pass

	
	pass
