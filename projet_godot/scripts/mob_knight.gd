extends Area2D

func _ready() -> void:
	$message.hide()

func show_message(_body):
	$Timer.start()
	$message.show()
	await $Timer.timeout
	$message.hide()

func hide_message(body: Node2D) -> void:
	$Timer.stop()
	$message.hide()
