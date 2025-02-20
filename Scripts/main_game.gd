class_name MainGame extends Node3D

#@export var targetScene: PackedScene
@export var targets_container: Node3D
@export var menu_scene: PackedScene
@onready var hud: Control = $UI/HUD



func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		hud.hide()
		var menu_scene_instantiate = menu_scene.instantiate()
		menu_scene_instantiate.show()
		$UI/Menus.add_child(menu_scene_instantiate)
	
	if event.is_action_pressed("slot_1"):
		SignalManager.current_bullet_selected.emit(1)
		pass
	if event.is_action_pressed("slot_2"):
		SignalManager.current_bullet_selected.emit(2)
		pass
	if event.is_action_pressed("slot_3"):
		SignalManager.current_bullet_selected.emit(3)
		pass

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#var tscene = targetScene.instantiate()
	#targets_container.add_child(tscene)
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
