extends RigidBody3D

@export var tree_scene : PackedScene
var current_position = Vector3.ZERO
#@onready var mesh_instance_3d: MeshInstance3D = $MeshInstance3D

func _ready() -> void:
	current_position = position
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bullet"):
		axis_lock_angular_y = false
		axis_lock_angular_z = false
		axis_lock_angular_x = false
		axis_lock_linear_y = false
		axis_lock_linear_z = false
		axis_lock_linear_x = false
		
		#SignalManager.touched_target.emit(-2)
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "scale", Vector3(0, 0,0 ), 1)
		#var test = tree_scene.instantiate()
		#test.position = current_position
		#add_child(test)
		#rotation_degrees.x = -90
