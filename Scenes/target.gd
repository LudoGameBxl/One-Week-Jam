extends Node3D



func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bullet"):
		var tween = get_tree().create_tween()
		tween.tween_property(self, "rotation_degrees", Vector3(-90, 0,0 ), 1)
		#rotation_degrees.x = -90
		print(body.bullet_type)
