extends Control

@export var animation_player:AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.close_curtain.connect(_on_curtain_close)
	EventBus.open_curtain.connect(_on_curtain_open)
	animation_player.play("Open")


func _on_curtain_open():
	animation_player.play("Open")


func _on_curtain_close():
	animation_player.play("Close")


func _on_curtain_opened():
	EventBus.curtain_opened.emit()


func _on_curtain_closed():
	EventBus.curtain_closed.emit()
