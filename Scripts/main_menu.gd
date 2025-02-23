extends Control

@onready var play_button: Button = %PlayButton
@onready var quit_button: Button = %QuitButton
@export var level_scene : PackedScene
@onready var game: Node3D = $"../../../Game"
@onready var hud: Control = $"../../HUD"
@onready var audio_stream_player: AudioStreamPlayer = $"../../../AudioStreamPlayer"
var levelscene = null

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	play_button.pressed.connect(play_button_pressed)
	quit_button.pressed.connect(quit_button_pressed)

func play_button_pressed() -> void:
	SignalManager.current_scene_menu.emit("hud_scene")
	if !game.get_child(0):
		levelscene = level_scene.instantiate()
		game.add_child(levelscene)
	#hud.show()
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	#queue_free()

func quit_button_pressed() -> void:
	get_tree().quit()
