extends Control

@onready var root: Control = $".."

var player_position := Vector2(298, 636)
var ai_position := Vector2(988, 81)

func _process(delta: float) -> void:
	if root.turn:
		global_position = player_position
	else:
		global_position = ai_position
