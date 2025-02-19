extends Node3D

const NOISETTE_CUBE_001 = preload("res://assets/concept/noisette.tres")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var sign_mesh_instance_3d: MeshInstance3D = $Node3D/SignMeshInstance3D

var current_position = Vector3.ZERO
var played = false

func _ready() -> void:
	current_position = position
	
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bullet") and !played:
		SignalManager.touched_target.emit(1)
		animation_player.play("rotate")
		await get_tree().create_timer(1.0).timeout
		sign_mesh_instance_3d.hide()
		played = true
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "scale", Vector3(0,0,0), 1)
		#await get_tree().create_timer(1.0).timeout
		#mesh_instance_3d.mesh = NOISETTE_CUBE_001
		#tween.tween_property(self, "scale", Vector3(1,1,1), 1)
