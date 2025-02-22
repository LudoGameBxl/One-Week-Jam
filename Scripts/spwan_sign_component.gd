extends Node3D

# Référence au RayCast3D
@export var raycast: RayCast3D

# Référence à la scène de l'objet à instancier
@export var object_scene: PackedScene
@onready var targets_container: Node3D = $"../TargetsContainer"

# Zone dans laquelle les objets peuvent être placés
@export var spawn_area: Vector3 = Vector3(30, 0, 30)

# Nombre d'objets à placer
@export var num_objects: int = 10

@export var spawn_center: Node3D

func _ready():
	for i in range(num_objects):
		place_object_randomly()
		
	#if spawn_area_visual and spawn_area_visual.mesh is BoxMesh:
		#spawn_area_visual.mesh.size = spawn_area

	
func place_object_randomly():
	if not spawn_center:
		return
	# Générer une position aléatoire dans la zone définie
	var random_position = spawn_center.global_position + Vector3(
		randf_range(-spawn_area.x / 2, spawn_area.x / 2),
		1,
		randf_range(-spawn_area.z / 2, spawn_area.z / 2)
	)
	
	

	# Déplacer le RayCast3D à la position aléatoire
	raycast.global_transform.origin = random_position

	# Lancer le raycast
	raycast.force_raycast_update()

	# Vérifier si le raycast a touché quelque chose
	if raycast.is_colliding():
		# Récupérer le point de collision
		var spawn_position = raycast.get_collision_point()

		# Instancier l'objet
		var new_object = object_scene.instantiate()
		targets_container.add_child(new_object)

		# Positionner l'objet au point de collision
		new_object.global_transform.origin = spawn_position
