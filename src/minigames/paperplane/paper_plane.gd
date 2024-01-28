extends CharacterBody3D


@export var move_speed:float = 1.0
@export var crash_scene:PackedScene
@export var model:Node3D

var _is_flying:= true


func _ready() -> void:
	EventBus.minigame_won.connect(_on_minigame_won)


func _physics_process(delta):
	if !_is_flying:
		return
	
	var move_vec = Vector3.ZERO
	move_vec.x = Input.get_axis("move_left", "move_right")
	move_vec.y = Input.get_axis("move_down", "move_up")
	move_vec = move_vec.normalized() * move_speed
	move_vec.z = -move_speed
	model.rotation_degrees.x = move_vec.y * 10
	model.rotation_degrees.y = move_vec.x * -10
	
	if move_and_collide(move_vec * delta):
		_on_collision()


func _on_collision() -> void:
	if !_is_flying:
		return
	EventBus.minigame_lost.emit()
	if crash_scene:
		var cs = crash_scene.instantiate()
		get_parent().add_child(cs)
		cs.global_transform = global_transform
	queue_free()


func _on_minigame_won() -> void:
	_is_flying = false
