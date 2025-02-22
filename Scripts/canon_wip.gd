extends Node3D

const BULLET = preload("res://Scenes/actors/bullets/bullet.tscn")
const NOISETTE_BULLET = preload("res://Scenes/actors/bullets/noisetteBullet.tscn")
const PING_BULLET = preload("res://Scenes/actors/bullets/PingBullet.tscn")

@onready var targets_container: Node3D = $"../TargetsContainer"
var target_count := 0
@onready var audio_stream_player: AudioStreamPlayer = $AudioStreamPlayer


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

@export var target: Sprite3D  # Ou MeshInstance3D si vous utilisez un QuadMesh

@export var offset_distance: float = 0.5  # Distance de décalage pour éviter de traverser la surface

func _ready() -> void:
	SignalManager.current_bullet_selected.connect(new_bullet_selected)
	SignalManager.touched_target.connect(touched_target)
	
	target_count = targets_container.get_child_count()
	
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
	
	if raycast.is_colliding():
		# Obtenir le point de collision
		
		if !"bullet_type" in raycast.get_collider():
			var collision_point = raycast.get_collision_point()
			var collision_normal = raycast.get_collision_normal()
			# Positionner la cible au point de collision
			var target_position = collision_point + collision_normal * offset_distance
			
			target.global_transform.origin = target_position
			
			align_with_normal(collision_normal)
		# Optionnel : Orienter la cible face à la caméra ou à l'origine du RayCast
		#var direction_to_camera = (collision_point - global_transform.origin).normalized()
		#target.look_at(collision_point + direction_to_camera, Vector3.UP)
	else:
		# Si le RayCast ne touche rien, vous pouvez cacher la cible ou la déplacer hors de l'écran
		target.global_transform.origin = Vector3(0, -1000, 0)  # Déplacer hors de la vue
		
	

func align_with_normal(normal: Vector3):
	# Calculer la rotation pour aligner la cible avec la normale
	var up_vector = Vector3.BACK  # Vecteur "haut" global

	if normal == up_vector:
		# Si la normale pointe vers le haut, pas besoin de rotation
		target.rotation = Vector3.ZERO
	else:
		# Calculer l'axe et l'angle de rotation pour aligner la cible avec la normale
		var axis = up_vector.cross(normal).normalized()
		var angle = up_vector.angle_to(normal)
		target.rotation = axis * angle

func shoot_projectile(force: float):
	if bullets_array_scene.size() == 3:
		var projectile = bullets_array_scene[current_bullet_selected].instantiate() as RigidBody3D
		get_parent().add_child(projectile) 

		projectile.global_transform.origin = raycast_point.global_transform.origin

		var direction = -raycast_point.global_transform.basis.z.normalized()
		if raycast.is_colliding():
			direction = (raycast.get_collision_point() - raycast_point.global_transform.origin).normalized()
		audio_stream_player.play()
		projectile.apply_impulse(direction * force)

func new_bullet_selected(bullet_number): 
	current_bullet_selected = bullet_number - 1

func touched_target(score):
	if target_count <= SignalManager.current_score:
		print('win')
