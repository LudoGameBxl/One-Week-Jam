extends Node3D

@export var targetScene: PackedScene
@export var targets_container: Node3D
@export var FloorMesh: MeshInstance3D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var tscene = targetScene.instantiate()
	targets_container.add_child(tscene)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
