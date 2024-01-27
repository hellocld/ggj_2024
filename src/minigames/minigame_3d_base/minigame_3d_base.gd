class_name MiniGame3DBase
extends Node3D

@export var game_time:float = 15.0
@export var game_announce_init:String
@export var game_announce_win:String = "Nice!"
@export var game_announce_lose:String = "Too Bad!"


func _ready() -> void:
	EventBus.minigame_announce.emit(game_announce_init)
	EventBus.minigame_start.emit()
	EventBus.minigame_timer_init.emit(game_time)
	EventBus.minigame_lost.connect(_on_game_lost)
	EventBus.minigame_won.connect(_on_game_won)


func _on_game_lost() -> void:
	EventBus.minigame_announce.emit(game_announce_lose)


func _on_game_won() -> void:
	EventBus.minigame_announce.emit(game_announce_win)
