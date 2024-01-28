extends Control


@export var heart_tex:Texture2D
@export var lives_container:Container

func _ready() -> void:
	EventBus.lives_changed.connect(_on_lives_changed)


func _on_lives_changed(lives:int):
	for child in lives_container.get_children():
		lives_container.remove_child(child)
		child.queue_free()
	for i in range(0, lives):
		var heart = TextureRect.new()
		heart.texture = heart_tex
		lives_container.add_child(heart)
