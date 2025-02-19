extends Node3D

@export var rotation_speed  = 0.5
var rotation_range: float = 55
@export var projectile_scene: PackedScene  # Référence à la scène du projectile
@export var max_force: float = 50.0  # Force max du tir
@export var charge_rate: float = 20.0  # Vitesse de chargement

@onready var raycast: RayCast3D = $RayCast3D  # RayCast pour la direction

var charge_time: float = 0.0
var charging: bool = false

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
		charging = true
		charge_time = 0.0  # Reset charge

	if Input.is_action_pressed("space") and charging:
		charge_time += delta * charge_rate
		charge_time = min(charge_time, max_force)  # Cap à max_force
		SignalManager.current_charge_time.emit(charge_time * 2)

	if Input.is_action_just_released("space") and charging:
		charging = false
		SignalManager.current_charge_time.emit(0)
		shoot_projectile(charge_time)

func shoot_projectile(force: float):
	if projectile_scene:
		var projectile = projectile_scene.instantiate() as RigidBody3D
		get_parent().add_child(projectile) 

		projectile.global_transform.origin = global_transform.origin

		var direction = -global_transform.basis.z.normalized()
		if raycast.is_colliding():
			direction = (raycast.get_collision_point() - global_transform.origin).normalized()

		projectile.apply_impulse(direction * force)
