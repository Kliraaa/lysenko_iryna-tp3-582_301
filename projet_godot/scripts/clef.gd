extends Area2D

func _on_body_entered(body: Node2D) -> void:
	print("Vous avez pris un clef")
	queue_free()
