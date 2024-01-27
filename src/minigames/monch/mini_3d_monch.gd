extends MiniGame3DBase

@export var reaction_delay:= 1.0
var delay_timer:SceneTreeTimer


func _ready() -> void:
	EventBus.monch_successful.connect(_on_monch_successful)
	EventBus.monch_failed.connect(_on_monch_failed)
	EventBus.minigame_timer_timeout.connect(_on_monch_failed)



func _on_monch_failed():
	delay_timer = get_tree().create_timer(reaction_delay)
	await delay_timer.timeout
	EventBus.minigame_lost.emit()


func _on_monch_successful(monchable:Food):
	delay_timer = get_tree().create_timer(reaction_delay)
	await delay_timer.timeout
	EventBus.minigame_won.emit()
