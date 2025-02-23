extends Control


@onready var restart_button: Button = %RestartButton
@onready var quit_button: Button = %QuitButton

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)
	restart_button.pressed.connect(restart_button_pressed)
	quit_button.pressed.connect(quit_button_pressed)

func restart_button_pressed() -> void:
	SignalManager.current_scene_menu.emit("restart_game")
	queue_free()

func quit_button_pressed() -> void:
	get_tree().quit()
