extends Node3D

@export var item_scene : PackedScene  # Scène de l'objet à faire apparaître
@export var spawn_area_size : Vector3 = Vector3(4, 0, 4)  # Taille de la zone de spawn
@export var spawn_count : int = 2  # Nombre d'items à spawn

var raycast : RayCast3D

func _ready():
	raycast = RayCast3D.new()  # Crée un RayCast3D
	add_child(raycast)
	raycast.target_position = Vector3(0, -10, 0)  # Dirige le rayon vers le bas
	
	for i in range(spawn_count):
		spawn_item()

func spawn_item():
	var spawn_pos = Vector3(
		randf_range(-spawn_area_size.x / 2, spawn_area_size.x / 2),
		5,
		randf_range(-spawn_area_size.y / 2, spawn_area_size.y / 2)
	)
	
	raycast.position = spawn_pos  # Positionne le RayCast à un endroit aléatoire

	raycast.force_raycast_update()
	if raycast.is_colliding():
		print("is colliding")
		var hit_pos = raycast.get_collision_point()  # Obtient la position de collision
		print(hit_pos)
		# hit_pos.y = hit_pos.y + 3
		var item_instance = item_scene.instantiate()  # Instancie l'objet
		item_instance.position = hit_pos  # Positionne l'objet sur le terrain
		add_child(item_instance)  # Ajoute l'objet à la scène
