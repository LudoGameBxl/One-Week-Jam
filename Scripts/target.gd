extends RigidBody3D

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bullet"):
		print("test touch")
		axis_lock_angular_y = false
		axis_lock_angular_z = false
		axis_lock_angular_x = false
		axis_lock_linear_y = false
		axis_lock_linear_z = false
		axis_lock_linear_x = false
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "scale", Vector3(0, 0,0 ), 1)
		#rotation_degrees.x = -90
		print(body.bullet_type)
