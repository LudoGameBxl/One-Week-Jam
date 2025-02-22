extends Node3D

const BULLET = preload("res://Scenes/actors/bullets/bullet.tscn")
const NOISETTE_BULLET = preload("res://Scenes/actors/bullets/noisetteBullet.tscn")
const PING_BULLET = preload("res://Scenes/actors/bullets/PingBullet.tscn")

@export var bullets_array_scene : Array = [
	BULLET,
	NOISETTE_BULLET,
	PING_BULLET
]

@export var rotation_speed  = 0.5
var rotation_range_v: float = 40
var rotation_range_h: float = 360
@export var max_force: float = 50.0  # Force max du tir
@export var charge_rate: float = 20.0  # Vitesse de chargement
@export var raycast_point: Node3D  # RayCast pour la direction
@export var canon: Node3D  # RayCast pour la direction
@export var raycast: RayCast3D

var charge_time: float = 0.0
var charging: bool = false
var current_bullet_selected = 0

func _ready() -> void:
	SignalManager.current_bullet_selected.connect(new_bullet_selected)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("left"):
		canon.rotation_degrees.y = canon.rotation_degrees.y + rotation_speed
	if Input.is_action_pressed("right"):
		canon.rotation_degrees.y = canon.rotation_degrees.y - rotation_speed
	if Input.is_action_pressed("up"):
		canon.rotation_degrees.x = clamp(canon.rotation_degrees.x + rotation_speed, -rotation_range_v, rotation_range_v)
	if Input.is_action_pressed("down"):
		canon.rotation_degrees.x = clamp(canon.rotation_degrees.x - rotation_speed, -rotation_range_v, rotation_range_v)
		
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
	if bullets_array_scene.size() == 3:
		var projectile = bullets_array_scene[current_bullet_selected].instantiate() as RigidBody3D
		get_parent().add_child(projectile) 

		projectile.global_transform.origin = raycast_point.global_transform.origin

		var direction = -raycast_point.global_transform.basis.z.normalized()
		if raycast.is_colliding():
			direction = (raycast.get_collision_point() - raycast_point.global_transform.origin).normalized()

		projectile.apply_impulse(direction * force)

func new_bullet_selected(bullet_number): 
	current_bullet_selected = bullet_number - 1
