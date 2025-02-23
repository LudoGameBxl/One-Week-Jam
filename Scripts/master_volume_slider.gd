extends HSlider
@onready var h_slider: HSlider = $"."

var bus_index: int
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bus_index = AudioServer.get_bus_index("Master")
	value_changed.connect(_on_value_changed)
	h_slider.value = db_to_linear(AudioServer.get_bus_volume_db(bus_index))
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(bus_index, linear_to_db(value))
