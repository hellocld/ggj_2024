extends Control

@export var animation_player:AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.minigame_start.connect(_on_game_start)
	EventBus.minigame_won.connect(_on_game_end)
	EventBus.minigame_lost.connect(_on_game_end)
	animation_player.play("Open")


func _on_game_start():
	animation_player.play("Open")


func _on_game_end():
	animation_player.play("Close")
	await animation_player.animation_finished
	EventBus.minigame_ready_for_next.emit()


