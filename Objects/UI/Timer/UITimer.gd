extends Control

func change_time(time:float) -> void:
	$Label.text = str(roundf(time))
