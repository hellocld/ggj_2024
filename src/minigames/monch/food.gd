class_name Food
extends Node3D

@export var monched_scene:PackedScene
@export var food_mesh:MeshInstance3D
@export var food_tex:Array[Texture2D]


func _ready() -> void:
	var mat = food_mesh.mesh.surface_get_material(0) as StandardMaterial3D
	mat.albedo_texture = food_tex[randi_range(0, food_tex.size() - 1)]

func monch(mouf:Node3D) -> void:
	visible = false
	if monched_scene != null && monched_scene.can_instantiate():
		var mon = monched_scene.instantiate() as Node3D
		get_parent().add_child(mon)
		mon.global_position = mouf.global_position
	queue_free()
