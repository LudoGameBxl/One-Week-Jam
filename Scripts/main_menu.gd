extends Control

@onready var play_button: Button = %PlayButton
@onready var quit_button: Button = %QuitButton
@export var level_scene : PackedScene
@onready var game: Node3D = $"../../../Game"
@onready var hud: Control = $"../../HUD"

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	play_button.pressed.connect(play_button_pressed)
	quit_button.pressed.connect(quit_button_pressed)

func play_button_pressed() -> void:
	if level_scene != null:
		var levelscene = level_scene.instantiate()
		game.add_child(levelscene)
	hud.show()
	queue_free()

func quit_button_pressed() -> void:
	get_tree().quit()
