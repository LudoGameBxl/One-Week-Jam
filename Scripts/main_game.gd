class_name MainGame extends Node3D

#@export var targetScene: PackedScene
@export var targets_container: Node3D
@onready var hud: Control = $UI/HUD
@onready var menus: Control = $UI/Menus
@onready var game: Node3D = $Game

@export var hud_scene: PackedScene
@export var menu_scene: PackedScene
@export var pause_scene: PackedScene

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("esc"):
		current_scene_menu("pause_menu")

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
	SignalManager.current_scene_menu.connect(current_scene_menu)
	#get_tree().paused = true
	pass
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func current_scene_menu(scene : String):
	for menu in menus.get_children():
		menus.remove_child(menu)
	match scene:
		"main_menu":
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			var menu_scene_instantiate = menu_scene.instantiate()
			menu_scene_instantiate.show()
			menus.add_child(menu_scene_instantiate)
		"pause_menu":
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			var menu_scene_instantiate = pause_scene.instantiate()
			menu_scene_instantiate.show()
			menus.add_child(menu_scene_instantiate)
		"hud_scene":
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			var menu_scene_instantiate = hud_scene.instantiate()
			menu_scene_instantiate.show()
			menus.add_child(menu_scene_instantiate)
		_: 
			print("scene not found")
