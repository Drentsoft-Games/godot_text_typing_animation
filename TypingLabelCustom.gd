extends "res://TypingLabel.gd"

var words: PoolStringArray
var space_positions: PoolIntArray

var offset_position: int = 0
var cur_word: int = 0

var stored_text: String = ""

var fill_character = " "

var randomise: bool = false

func set_text(new_text: String):
	offset_position = 0
	cur_word = 0
	stored_text = ""
	words = new_text.split(" ", false)
	space_positions = PoolIntArray()
	for i in range(text.length()):
		if new_text.substr(i, 1) == " ":
			space_positions.append(i)

func set_fill_character(fill_char: String):
	fill_character = fill_char

func randomise(r: bool):
	randomise = r

func fill_word(word: String, position: int):
	var output = word.substr(0, position)
	var space_len = word.length() - position
	for i in range(space_len):
		if randomise:
			output += get_random_fill_character()
		else:
			output += fill_character
	return output

func get_random_fill_character() -> String:
	var char_id = randi() % fill_character.length()
	return fill_character.substr(char_id, 1)

func _on_Timer_timeout():
	offset_position += 1
	var filled = fill_word(words[cur_word], offset_position)
	text = stored_text + fill_word(words[cur_word], offset_position)
	yield(get_tree(), "idle_frame")
	if offset_position == words[cur_word].length():
		stored_text += words[cur_word]
		cur_word += 1
		offset_position = 0
		if cur_word < words.size():
			stored_text += " "
	if cur_word == words.size():
		$Timer.stop()
		emit_signal("text_typing_finished")
