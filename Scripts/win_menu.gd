extends Control

@onready var resume_button: Button = %ResumeButton
@onready var quit_button: Button = %QuitButton
@export var level_scene : PackedScene
@onready var restart_button: Button = %RestartButton

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	resume_button.pressed.connect(resume_button_pressed)
	quit_button.pressed.connect(quit_button_pressed)
	restart_button.pressed.connect(restart_button_pressed)

func resume_button_pressed() -> void:
	SignalManager.current_scene_menu.emit("hud_scene")


func quit_button_pressed() -> void:
	get_tree().quit()

func restart_button_pressed():
	SignalManager.current_scene_menu.emit("restart_game")
