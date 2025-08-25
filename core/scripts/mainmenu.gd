extends Control

func _on_singleplayer_pressed() -> void:
	Handler.loadout("pull", self)
	Handler.singleplayer()

func _on_host_pressed() -> void:
	Handler.host()


func _on_join_pressed() -> void:
	Handler.join()
