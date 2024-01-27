extends Control

@export var timer_slider:HSlider

var _running:= false

func _ready():
	EventBus.minigame_start.connect(start_timer)
	EventBus.minigame_announce.connect(init_timer)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _running:
		timer_slider.value -= delta
		if timer_slider.value <= 0:
			EventBus.minigame_timer_timeout.emit()
			_running = false


func init_timer() -> void:
	timer_slider.value = timer_slider.max_value


func start_timer() -> void:
	_running = true
