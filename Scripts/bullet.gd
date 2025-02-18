class_name Projectile extends RigidBody3D

@export var lifetime: float = 5.0 
@export var bullet_type = "bullet_1"

func _ready():
	await get_tree().create_timer(lifetime).timeout
	name = "Bullet"
	queue_free()  #Auto desruction after lifetime (opt)
