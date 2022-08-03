extends "res://TypingLabel.gd"

var pc: float

func set_text(new_text: String):
	text = new_text
	percent_visible = 0.0
	yield(get_tree(), "idle_frame")
	pc = 1.0 / text.length()

func _on_Timer_timeout():
	percent_visible += pc
	if percent_visible >= 1.0:
		$Timer.stop()
		emit_signal("text_typing_finished")
