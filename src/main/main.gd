extends Node3D

@export var minigame_root:Node
@export var minigames:Array[PackedScene]
@export var max_lives:int = 3
@export var hide_mouse:bool = true
var _current_game_idx:int

@onready var _lives = max_lives


func _ready() -> void:
	if hide_mouse:
		Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	EventBus.minigame_cleanup_complete.connect(_on_game_get_next)
	EventBus.minigame_cleanup.connect(_clear_current_minigame)
	EventBus.minigame_lost.connect(_on_game_lost)
	EventBus.game_over.connect(_on_game_over)
	EventBus.lives_changed.emit(_lives)
	_on_game_get_next()


func _process(_delta) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()


func _launch_game(game:PackedScene) -> void:
	var new_game = game.instantiate()
	minigame_root.add_child(new_game)
	EventBus.open_curtain.emit()


func _clear_current_minigame() -> void:
	EventBus.close_curtain.emit()
	await EventBus.curtain_closed
	for child in minigame_root.get_children():
		minigame_root.remove_child(child)
		child.queue_free()
	EventBus.minigame_cleanup_complete.emit()


func _on_game_get_next() -> void:
	if _lives <= 0:
		EventBus.game_over.emit()
	else:
		_get_next_random_game()


func _on_game_lost() -> void:
	_lives -= 1
	EventBus.lives_changed.emit(_lives)


func _get_next_random_game() -> void:
	var new_game_idx = randi_range(0, minigames.size() - 1)
	if _current_game_idx == new_game_idx:
		_get_next_random_game()
	else:
		_current_game_idx = new_game_idx
		_launch_game(minigames[new_game_idx])


func _on_game_over() -> void:
	EventBus.show_game_over.emit()
	await EventBus.game_over_screen_ready
	MusicPlayer.stop_song()
	EventBus.open_curtain.emit()
