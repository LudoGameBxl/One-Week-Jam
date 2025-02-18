extends Control

@onready var charge_time_progress_bar: ProgressBar = %ChargeTimeProgressBar


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	SignalManager.current_charge_time.connect(update_progress_bar)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func update_progress_bar(charge_value):
	charge_time_progress_bar.value = charge_value
