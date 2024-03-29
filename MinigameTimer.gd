extends Control

@export var timer_slider:TextureProgressBar

var _running:= false

func _ready():
	EventBus.minigame_start.connect(start_timer)
	EventBus.minigame_timer_init.connect(init_timer)
	EventBus.minigame_timer_stop.connect(stop_timer)
	EventBus.game_over.connect(_on_game_over)


func _process(delta):
	if _running:
		timer_slider.value -= delta
		if timer_slider.value <= 0:
			EventBus.minigame_timer_timeout.emit()
			_running = false


func init_timer(time) -> void:
	visible = true
	timer_slider.max_value = time
	timer_slider.value = timer_slider.max_value


func start_timer() -> void:
	_running = true


func stop_timer() -> void:
	_running = false


func _on_game_over():
	visible = false
