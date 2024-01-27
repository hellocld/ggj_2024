class_name Food
extends Node3D

@export var monched_scene:PackedScene

func monch(mouf:Node3D) -> void:
	visible = false
	if monched_scene != null && monched_scene.can_instantiate():
		var mon = monched_scene.instantiate() as Node3D
		get_parent().add_child(mon)
		mon.global_position = mouf.global_position
	queue_free()
