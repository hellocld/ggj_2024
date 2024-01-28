extends MiniGame3DBase


@export var tunnel_root:Node3D
@export var empty_tunnel:PackedScene
@export var tunnel_pieces:Array[PackedScene]


func _ready() -> void:
	_instance_tunnel()
	EventBus.minigame_timer_timeout.connect(_on_timer_timeout)
	super._ready()


func _instance_tunnel() -> void:
	for i in range (-3, 2):
		var piece = empty_tunnel.instantiate()
		tunnel_root.add_child(piece)
		piece.position.z = -i * 3
	for i in range (2, 20):
		var piece = tunnel_pieces[randi_range(0, tunnel_pieces.size() - 1)]
		var instance_piece = piece.instantiate()
		tunnel_root.add_child(instance_piece)
		instance_piece.position.z = -i * 3


func _on_timer_timeout():
	EventBus.minigame_won.emit()
