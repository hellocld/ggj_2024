class_name MiniGame3DBase
extends Node3D

@export var game_announce_init:String
@export var game_announce_win:String = "Nice!"
@export var game_announce_lose:String = "Too Bad!"

func _ready() -> void:
	EventBus.minigame_announce.emit(game_announce_init)
