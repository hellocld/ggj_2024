extends Node3D

@export var minigame_root:Node
@export var minigames:Array[PackedScene]



func _ready() -> void:
	EventBus.minigame_ready_for_next.connect(_on_game_won)
	# TESTING
	if minigames.size() > 0:
		_launch_game(minigames[0])


func _launch_game(game:PackedScene) -> void:
	if minigame_root.get_child_count() > 0:
		var child = minigame_root.get_child(0)
		minigame_root.remove_child(child)
		child.queue_free()
	var new_game = game.instantiate()
	minigame_root.add_child(new_game)


func _on_game_won() -> void:
	minigames.shuffle()
	_launch_game(minigames[0])

