extends Control

@export var announce_label:Label
@export var announce_time:= 1.0
@export var label_center:Control
@export var bob_range:= 5.0
@export var bob_rate = 0.5

var _start_pos: float
var _wibble: float = 0.0


func _ready() -> void:
	EventBus.minigame_announce.connect(_on_announce)
	_start_pos = label_center.position.y
	announce_label.text = ""


func _physics_process(delta) -> void:
	_wibble += (delta * bob_rate)
	_wibble = wrapf(_wibble, 0, PI * 2)
	label_center.position.y = _start_pos + sin(_wibble) * bob_range


func _on_announce(text:String) -> void:
	visible = true
	announce_label.text = text
	var timer = get_tree().create_timer(1.0)
	await timer.timeout
	visible = false
