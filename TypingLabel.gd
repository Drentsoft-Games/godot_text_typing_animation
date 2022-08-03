extends Label

signal text_typing_started
signal text_typing_finished

func start_animation():
	$Timer.start()
	emit_signal("text_typing_started")
