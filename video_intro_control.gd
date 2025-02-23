extends Control

@export var game_scene : PackedScene
# Called when the node enters the scene tree for the first time.

func _input(event: InputEvent) -> void:
	print(event.is_action_type())
	if event.is_action_type():
		var game_scene_instantiate = game_scene.instantiate()
		get_parent().add_child(game_scene_instantiate)
		queue_free()

func _on_video_stream_player_finished() -> void:
	var game_scene_instantiate = game_scene.instantiate()
	get_parent().add_child(game_scene_instantiate)
	queue_free()
