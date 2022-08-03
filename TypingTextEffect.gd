extends Control

const APPEND_LABEL = preload("res://TypingLabelAppend.gd")
const PERCENT_LABEL = preload("res://TypingLabelPercent.gd")
const CUSTOM_LABEL = preload("res://TypingLabelCustom.gd")

func _ready():
	set_connections()
	_on_AppendMode_pressed()

func set_connections():
	$TypingLabel/Timer.connect("timeout", $TypingLabel, "_on_Timer_timeout")
	$TypingLabel.connect("text_typing_started", self, "on_typing_started")
	$TypingLabel.connect("text_typing_finished", self, "on_typing_ended")

func _on_AppendMode_pressed():
	$TypingLabel.set_script(APPEND_LABEL)
	press_button($Modes/AppendMode)

func _on_PercentMode_pressed():
	$TypingLabel.set_script(PERCENT_LABEL)
	press_button($Modes/PercentMode)
	
func _on_CustomMode_pressed():
	$TypingLabel.set_script(CUSTOM_LABEL)
	press_button($Modes/AppendMode)
	$TypingLabel.set_fill_character($Modes/CustomMode/FillChar.text)
	$TypingLabel.randomise($Modes/CustomMode/Randomise.pressed)

func press_button(button):
	for b in $Modes.get_children():
		if b == button:
			button.pressed = true
		else:
			button.pressed = false

func lock_ui():
	for button in $Modes.get_children():
		button.disabled = true
	$TimerDelay.editable = false

func unlock_ui():
	for button in $Modes.get_children():
		button.disabled = false
	$TimerDelay.editable = true

func _on_Start_pressed():
	if $TypingLabel/Timer.is_stopped():
		$TypingLabel.set_text($ExampleText.text)
		$TypingLabel.start_animation()
		on_typing_started()
	else:
		on_typing_ended()

func on_typing_started():
	$Start.text = "Stop"
	lock_ui()

func on_typing_ended():
	$TypingLabel/Timer.stop()
	$Start.text = "Start"
	unlock_ui()

func _on_FillChar_text_changed():
	$Modes/CustomMode/Randomise.disabled = !$Modes/CustomMode/FillChar.text.length() > 1

func _on_TimerDelay_value_changed(value):
	$TypingLabel/Timer.wait_time = $TimerDelay.value
