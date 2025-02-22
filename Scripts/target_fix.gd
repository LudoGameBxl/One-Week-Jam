extends Node3D

const NOISETTE_CUBE_001 = preload("res://assets/concept/noisette.tres")
@onready var animation_player: AnimationPlayer = $AnimationPlayer
const ARBRE_01 = preload("res://Scenes/arbre_01.tscn")
const ARBRE_02 = preload("res://Scenes/arbre_02.tscn")
var current_position = Vector3.ZERO
var played = false
@onready var tree_container: Node3D = $Node3D/tree_container

@onready var house_sig_n: MeshInstance3D = %HouseSigN
@onready var super_market_sign: MeshInstance3D = %SuperMarketSign

func _ready() -> void:
	current_position = position
	var rand = randi_range(1,2)
	if rand == 1:
		house_sig_n.hide()
		super_market_sign.show()
	else:
		house_sig_n.show()
		super_market_sign.hide()

func _process(delta: float) -> void:
	pass


func _on_area_3d_body_entered(body: Node3D) -> void:
	if body.is_in_group("bullet") and !played:
	
		var tree
		if body.bullet_type == "bullet_2":
			tree = ARBRE_01.instantiate()
		elif body.bullet_type == "bullet_3":
			tree = ARBRE_02.instantiate()
		else:
			if randi_range(1,2) == 1:
				tree = ARBRE_01.instantiate()
			else:
				tree = ARBRE_02.instantiate()
		tree.rotate_x(deg_to_rad(180))
		tree_container.add_child(tree)
		SignalManager.touched_target.emit(1)
		animation_player.play("rotate")
		await get_tree().create_timer(1.0).timeout
		super_market_sign.hide()
		house_sig_n.hide()
		played = true
		#var tween = get_tree().create_tween()
		#tween.tween_property(self, "scale", Vector3(0,0,0), 1)
		#await get_tree().create_timer(1.0).timeout
		#mesh_instance_3d.mesh = NOISETTE_CUBE_001
		#tween.tween_property(self, "scale", Vector3(1,1,1), 1)
