extends Control

@onready var charge_time_progress_bar: ProgressBar = %ChargeTimeProgressBar
@onready var label: Label = %Label
@onready var slot_grid_container: GridContainer = %SlotGridContainer
@onready var slot_1: Panel = $MarginContainer/HBoxContainer2/SlotGridContainer/Slot_1

func _ready() -> void:
	hide()
	SignalManager.current_charge_time.connect(update_progress_bar)
	SignalManager.touched_target.connect(touched_target)
	SignalManager.current_bullet_selected.connect(new_bullet_selected)

func _process(delta: float) -> void:
	pass

func update_progress_bar(charge_value):
	charge_time_progress_bar.value = charge_value
	
func touched_target(score):
	SignalManager.current_score = SignalManager.current_score + score
	label.text = "score: " + str(SignalManager.current_score)

func new_bullet_selected(new_slot_active_number)-> void:
#	TODO: finish this fonction change bg color on select 
	slot_1.set_bg_color()
	pass
	#for slot in slot_grid_container.get_children():
		#slot.bg_color = Color.LAWN_GREEN
