extends Node3D

@export var item_scene: PackedScene
@export var terrain: NodePath
@export var spawn_area: Vector3 = Vector3(5, 0, 5)  # Zone de spawn (X, Z)

func _ready():
	spawn_item()

func spawn_item():
	# Générer une position aléatoire dans la zone de spawn
	var random_x = randf_range(-spawn_area.x / 2, spawn_area.x / 2)
	var random_z = randf_range(-spawn_area.z / 2, spawn_area.z / 2)
	#var spawn_position = Vector3(random_x, 0, random_z)
	var spawn_position = Vector3(0, 5, 0)

	# Utiliser un RayCast pour trouver la hauteur du terrain
	var raycast = RayCast3D.new()
	raycast.position = spawn_position
	raycast.target_position = Vector3(0, -100, 0)  # Lancer un rayon vers le bas
	raycast.enabled = true
	add_child(raycast)

	# Attendre une frame pour que le RayCast se mette à jour
	await get_tree().process_frame

	if raycast.is_colliding():
		print("collidinggggggggggggg")
		var collision_point = raycast.get_collision_point()
		spawn_position.y = collision_point.y  # Ajuster la hauteur

	# Supprimer le RayCast après utilisation
	raycast.queue_free()

	# Instancier l'item et le placer à la bonne position
	var item = item_scene.instantiate()
	add_child(item)
	item.global_transform.origin = spawn_position
