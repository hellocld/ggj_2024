extends Node3D


@export var move_speed:= 2.0
@export var random_time:= 0.5

var _target_pos:Vector3
var _timer:SceneTreeTimer

var _moving:= true

func _ready() -> void:
	_set_timer()
	_set_rand_target()
	EventBus.monch_failed.connect(_on_monch_fail)
	EventBus.monch_successful.connect(_on_monch_success)


func _process(delta) -> void:
	if !_moving:
		return
	var dir = (_target_pos - global_position).normalized()
	translate(dir * delta * move_speed)
	if global_position.distance_to(_target_pos) < 0.1:
		_set_rand_target()


func _on_monch_success(_monchable) -> void:
	_moving = false

func _on_monch_fail() -> void:
	_moving = false

func _set_rand_target() -> void:
	_target_pos.x = randf_range(-1, 1)
	_target_pos.y = randf_range(-1, 1)
	if global_position.distance_to(_target_pos) < 0.5:
		_set_rand_target()


func _set_timer() -> void:
	_timer = get_tree().create_timer(random_time)
	_timer.timeout.connect(_set_rand_target)
