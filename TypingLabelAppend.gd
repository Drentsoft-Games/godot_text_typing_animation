extends "res://TypingLabel.gd"

var full_text: String
var character_pos: int = 0

func set_text(new_text: String):
	full_text = new_text
	character_pos = 0

func _on_Timer_timeout():
	character_pos += 1
	text = full_text.substr(0, character_pos)
	if character_pos == full_text.length():
		$Timer.stop()
		emit_signal("text_typing_finished")
