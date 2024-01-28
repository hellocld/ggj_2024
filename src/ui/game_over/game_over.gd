extends Control


func _ready() -> void:
	visible = false
	EventBus.show_game_over.connect(_on_show_game_over)


func _process(_delta):
	if visible:
		if Input.is_action_just_pressed("interact"):
			EventBus.main_menu_requested.emit()


func _on_show_game_over():
	visible = true
	await get_tree().process_frame
	EventBus.game_over_screen_ready.emit()
