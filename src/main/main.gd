extends Node3D

@export var minigame_root:Node
@export var minigames:Array[PackedScene]

var _current_game:PackedScene

func _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CONFINED_HIDDEN
	EventBus.minigame_ready_for_next.connect(_on_game_won)
	# TESTING
	if minigames.size() > 0:
		_launch_game(minigames[0])


func _process(_delta) -> void:
	if Input.is_action_just_pressed("quit"):
		get_tree().quit()

func _launch_game(game:PackedScene) -> void:
	if minigame_root.get_child_count() > 0:
		var child = minigame_root.get_child(0)
		minigame_root.remove_child(child)
		child.queue_free()
	var new_game = game.instantiate()
	minigame_root.add_child(new_game)
	_current_game = game


func _on_game_won() -> void:
	_get_next_random_game()


func _get_next_random_game() -> void:
	minigames.shuffle()
	if minigames[0] == _current_game:
		_get_next_random_game()
	_launch_game(minigames[0])
