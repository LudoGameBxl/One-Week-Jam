class_name MainGame extends Node3D

#@export var targetScene: PackedScene
@export var targets_container: Node3D
@onready var hud: Control = $UI/HUD
@onready var menus: Control = $UI/Menus
@onready var game: Node3D = $Game

@export var hud_scene: PackedScene
@export var menu_scene: PackedScene
@export var pause_scene: PackedScene
@export var win_scene: PackedScene
@export var gameover_scene: PackedScene
@export var game_level: PackedScene


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

func start_game_data():
	SignalManager.bullets_attempts = 3
	SignalManager.current_score = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.current_scene_menu.connect(current_scene_menu)
	get_tree().paused = true
	#start_game_data()
	
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
		"win_menu":
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			var menu_scene_instantiate = win_scene.instantiate()
			menu_scene_instantiate.show()
			menus.add_child(menu_scene_instantiate)
		"gameover_menu":
			get_tree().paused = true
			Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
			var menu_scene_instantiate = gameover_scene.instantiate()
			menu_scene_instantiate.show()
			menus.add_child(menu_scene_instantiate)
		"restart_game":
			start_game_data()
			get_tree().paused = false
			for gameChild in game.get_children():
				game.remove_child(gameChild)
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			var game_lvl_instantiate = game_level.instantiate()
			game_lvl_instantiate.show()
			game.add_child(game_lvl_instantiate)
			SignalManager.current_scene_menu.emit("hud_scene")
		"hud_scene":
			get_tree().paused = false
			Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
			var menu_scene_instantiate = hud_scene.instantiate()
			menu_scene_instantiate.show()
			menus.add_child(menu_scene_instantiate)
		_: 
			print("scene not found")
