class_name MiniGame3DBase
extends Node3D


func game_lost() -> void:
	EventBus.minigame_lost.emit()


func game_won() -> void:
	pass
