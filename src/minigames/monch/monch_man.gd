class_name  MonchMan
extends Node3D

signal man_monched()

@export var move_speed:= 1.0

var _pre_monch = true

var _monchable: Food = null

@export_category("Brows")
@export var brows:MeshInstance3D
@export var brow_mad:CompressedTexture2D
@export var brow_sad:CompressedTexture2D
var _brow_mat:StandardMaterial3D

@export_category("Eyes")
@export var eyes:MeshInstance3D
@export var eyes_open:CompressedTexture2D
@export var eyes_sad:CompressedTexture2D
@export var eyes_glad:CompressedTexture2D
var _eye_mat:StandardMaterial3D

@export_category("Mouf")
@export var mouf:MeshInstance3D
@export var mouf_area:Area3D
@export var mouf_open:CompressedTexture2D
@export var mouf_closed:CompressedTexture2D
@export var mouf_sad:CompressedTexture2D
@export var mouf_glad:CompressedTexture2D
var _mouf_mat:StandardMaterial3D


func _ready() -> void:
	_mouf_mat = mouf.mesh.surface_get_material(0) as StandardMaterial3D
	_eye_mat = eyes.mesh.surface_get_material(0) as StandardMaterial3D
	_brow_mat = brows.mesh.surface_get_material(0) as StandardMaterial3D
	_default_face()
	EventBus.minigame_won.connect(_on_game_won)
	EventBus.minigame_lost.connect(_on_game_lost)


func _process(_delta) -> void:
	if !_pre_monch:
		return
	if Input.is_action_just_pressed("interact"):
		_monch()


func _physics_process(delta) -> void:
	if !_pre_monch:
		return
	var move_vec = Vector3.ZERO
	move_vec.x = Input.get_axis("move_left", "move_right")
	move_vec.y = Input.get_axis("move_down", "move_up")
	translate(move_vec.normalized() * move_speed * delta)



func _monch() -> void:
	EventBus.minigame_timer_stop.emit()
	MusicPlayer.stop_song()
	_pre_monch = false
	_mouf_mat.albedo_texture = mouf_closed
	if _monchable == null:
		EventBus.monch_failed.emit()
	else:
		_monchable.monch(mouf_area)
		EventBus.monch_successful.emit(_monchable)


func _default_face() -> void:
	_mouf_mat.albedo_texture = mouf_open
	_brow_mat.albedo_texture = brow_mad
	_eye_mat.albedo_texture = eyes_open


func _happy_face() -> void:
	_mouf_mat.albedo_texture = mouf_glad
	_eye_mat.albedo_texture = eyes_glad


func _sad_face() -> void:
	_mouf_mat.albedo_texture = mouf_sad
	_eye_mat.albedo_texture = eyes_sad
	_brow_mat.albedo_texture = brow_sad


func _on_game_won() -> void:
	_pre_monch = false
	_happy_face()

func _on_game_lost() -> void:
	_pre_monch = false
	_sad_face()


func _on_mouf_area_3d_area_entered(area):
	_monchable = area.get_parent() as Food


func _on_mouf_area_3d_area_exited(area):
	_monchable = null
