class_name MiniGame3DBase
extends Node3D

@export var game_time:float = 15.0

@export_category("Announcements")
@export var game_announce_init:String
@export var game_announce_win:String = "Nice!"
@export var game_announce_lose:String = "Too Bad!"

@export_category("Music")
@export var main_song:AudioStream
@export var win_song:AudioStream
@export var lose_song:AudioStream


func _ready() -> void:
	EventBus.minigame_lost.connect(_on_game_lost)
	EventBus.minigame_won.connect(_on_game_won)
	# Show the announcement UI label
	EventBus.minigame_announce.emit(game_announce_init)
	# Announce the start of the minigame
	EventBus.minigame_start.emit()
	# Alert the timer to reset with game time
	EventBus.minigame_timer_init.emit(game_time)
	if main_song:
		MusicPlayer.play_song(main_song)


func _on_game_lost() -> void:
	EventBus.minigame_announce.emit(game_announce_lose)
	EventBus.minigame_timer_stop.emit()
	if lose_song:
		MusicPlayer.play_song(lose_song)
	_queue_next_game()


func _on_game_won() -> void:
	EventBus.minigame_announce.emit(game_announce_win)
	EventBus.minigame_timer_stop.emit()
	if win_song:
		MusicPlayer.play_song(win_song)
	_queue_next_game()


func _queue_next_game() -> void:
	EventBus.minigame_cleanup.emit()


