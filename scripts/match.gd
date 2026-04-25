extends Control

@onready var board_places: Control = $"Board Places"
@onready var highlighting: Control = $Highlighting
@onready var pawn_b: Node2D = $PawnB

const INDICATOR_POSSIBLE = preload("uid://jwcesd0w5er")
const INDICATOR_SELECTED = preload("uid://6cjjdud1fvr")
const BLACK_BISHOP = preload("uid://cbbpyg0o6am7f")
const BLACK_KING = preload("uid://csxjs22db2fwk")
const BLACK_KNIGHT = preload("uid://78x7unrttfjs")
const BLACK_PAWN = preload("uid://dtp3o7niklaab")
const BLACK_QUEEN = preload("uid://pyx0jk6vqvl3")
const BLACK_ROOK = preload("uid://wu7hjhsnwt6q")
const BISHOP = preload("uid://dn4wx5exxkd6j")
const KING = preload("uid://b1yxhruleaevk")
const KNIGHT = preload("uid://dopoqmcy33btu")
const PAWN = preload("uid://c248glb1xysec")
const QUEEN = preload("uid://8awts0j264pv")
const ROOK = preload("uid://ddt470jlxupw3")

var selected: int
var indicator_sel_spawned: bool

var piece_to_instance := {
	"bishop" : BISHOP,
	"rook" : ROOK,
	"king" : KING,
	"knight" : KNIGHT,
	"pawn" : PAWN,
	"queen" : QUEEN,
	"bishopb" : BLACK_BISHOP,
	"rookb" : BLACK_ROOK,
	"kingb" : BLACK_KING,
	"knightb" : BLACK_KNIGHT,
	"pawnb" : BLACK_PAWN,
	"queenb" : BLACK_QUEEN,
}

func _ready() -> void:
	spawn_pieces()

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("l_click"):
		var mouse_pos := get_global_mouse_position()

func _process(delta: float) -> void:
	# Indicator Logic
	if selected > 0 and !indicator_sel_spawned:
		if board_places.get_child(selected - 1).get_children() != []:
			if board_places.get_child(selected - 1).get_child(0).is_in_group("white"):
				highlight_selected_piece()

func move_to(piece: Node2D, place_num: int):
	var square := board_places.get_child(place_num - 1)
	var piece_type: String
	match piece.get_groups():
		["bishop", "pieces"]:
			piece_type = "bishop"
		["rook", "pieces"]:
			piece_type = "rook"
		["king", "pieces"]:
			piece_type = "king"
		["knight", "pieces"]:
			piece_type = "knight"
		["pawn", "pieces"]:
			piece_type = "pawn"
		["queen", "pieces"]:
			piece_type = "queen"
		["bishopb", "pieces"]:
			piece_type = "bishopb"
		["rookb", "pieces"]:
			piece_type = "rookb"
		["kingb", "pieces"]:
			piece_type = "kingb"
		["knightb", "pieces"]:
			piece_type = "knightb"
		["pawnb", "pieces"] :
			piece_type = "pawnb"
			print("here")
		["queenb", "pieces"]:
			piece_type = "queenb"
	var instance  = piece_to_instance[piece_type].instantiate()
	square.add_child(instance)
	piece.queue_free()

func spawn_pieces() -> void:
	await get_tree().create_timer(0.1).timeout
	add_piece("rookb", 1)
	add_piece("rook", 64)
	await get_tree().create_timer(0.1).timeout
	add_piece("knightb", 2)
	add_piece("knight", 63)
	await get_tree().create_timer(0.1).timeout
	add_piece("bishopb", 3)
	add_piece("bishop", 62)
	await get_tree().create_timer(0.1).timeout
	add_piece("queenb", 4)
	add_piece("king", 61)
	await get_tree().create_timer(0.1).timeout
	add_piece("kingb", 5)
	add_piece("queen", 60)
	await get_tree().create_timer(0.1).timeout
	add_piece("bishopb", 6)
	add_piece("bishop", 59)
	await get_tree().create_timer(0.1).timeout
	add_piece("knightb", 7)
	add_piece("knight", 58)
	await get_tree().create_timer(0.1).timeout
	add_piece("rookb", 8)
	add_piece("rook", 57)
	await get_tree().create_timer(0.1).timeout
	for i in range(8):
		add_piece("pawnb", 9 + i)
		add_piece("pawn", 56 - i)
		await get_tree().create_timer(0.1).timeout

func add_piece(piece, place_num) -> void:
	var square := board_places.get_child(place_num - 1)
	var instance  = piece_to_instance[piece].instantiate()
	square.add_child(instance)

func highlight_selected_piece() -> void:
	for i in get_tree().get_nodes_in_group("indicators"):
		i.queue_free()
	var instance  = INDICATOR_SELECTED.instantiate()
	var square = highlighting.get_child(selected - 1)
	square.add_child(instance)
	instance.add_to_group("indicators")
	indicator_sel_spawned = true

# CLICKSSS #

func _on_pressed_1(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 1
		indicator_sel_spawned = false

func _on_pressed_2(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 2
		indicator_sel_spawned = false

func _on_pressed_3(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 3
		indicator_sel_spawned = false

func _on_pressed_4(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 4
		indicator_sel_spawned = false

func _on_pressed_5(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 5
		indicator_sel_spawned = false

func _on_pressed_6(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 6
		indicator_sel_spawned = false

func _on_pressed_7(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 7
		indicator_sel_spawned = false

func _on_pressed_8(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 8
		indicator_sel_spawned = false

func _on_pressed_9(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 9
		indicator_sel_spawned = false

func _on_pressed_10(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 10
		indicator_sel_spawned = false

func _on_pressed_11(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 11
		indicator_sel_spawned = false

func _on_pressed_12(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 12
		indicator_sel_spawned = false

func _on_pressed_13(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 13
		indicator_sel_spawned = false

func _on_pressed_14(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 14
		indicator_sel_spawned = false

func _on_pressed_15(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 15
		indicator_sel_spawned = false

func _on_pressed_16(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 16
		indicator_sel_spawned = false

func _on_pressed_17(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 17
		indicator_sel_spawned = false

func _on_pressed_18(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 18
		indicator_sel_spawned = false

func _on_pressed_19(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 19
		indicator_sel_spawned = false

func _on_pressed_20(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 20
		indicator_sel_spawned = false

func _on_pressed_21(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 21
		indicator_sel_spawned = false

func _on_pressed_22(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 22
		indicator_sel_spawned = false

func _on_pressed_23(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 23
		indicator_sel_spawned = false

func _on_pressed_24(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 24
		indicator_sel_spawned = false

func _on_pressed_25(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 25
		indicator_sel_spawned = false

func _on_pressed_26(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 26
		indicator_sel_spawned = false

func _on_pressed_27(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 27
		indicator_sel_spawned = false

func _on_pressed_28(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 28
		indicator_sel_spawned = false

func _on_pressed_29(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 29
		indicator_sel_spawned = false

func _on_pressed_30(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 30
		indicator_sel_spawned = false

func _on_pressed_31(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 31
		indicator_sel_spawned = false

func _on_pressed_32(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 32
		indicator_sel_spawned = false

func _on_pressed_33(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 33
		indicator_sel_spawned = false

func _on_pressed_34(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 34
		indicator_sel_spawned = false

func _on_pressed_35(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 35
		indicator_sel_spawned = false

func _on_pressed_36(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 36
		indicator_sel_spawned = false

func _on_pressed_37(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 37
		indicator_sel_spawned = false

func _on_pressed_38(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 38
		indicator_sel_spawned = false

func _on_pressed_39(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 39
		indicator_sel_spawned = false

func _on_pressed_40(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 40
		indicator_sel_spawned = false

func _on_pressed_41(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 41
		indicator_sel_spawned = false

func _on_pressed_42(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 42
		indicator_sel_spawned = false

func _on_pressed_43(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 43
		indicator_sel_spawned = false

func _on_pressed_44(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 44
		indicator_sel_spawned = false

func _on_pressed_45(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 45
		indicator_sel_spawned = false

func _on_pressed_46(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 46
		indicator_sel_spawned = false

func _on_pressed_47(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 47
		indicator_sel_spawned = false

func _on_pressed_48(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 48
		indicator_sel_spawned = false

func _on_pressed_49(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 49
		indicator_sel_spawned = false

func _on_pressed_50(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 50
		indicator_sel_spawned = false

func _on_pressed_51(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 51
		indicator_sel_spawned = false

func _on_pressed_52(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 52
		indicator_sel_spawned = false

func _on_pressed_53(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 53
		indicator_sel_spawned = false

func _on_pressed_54(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 54
		indicator_sel_spawned = false

func _on_pressed_55(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 55
		indicator_sel_spawned = false

func _on_pressed_56(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 56
		indicator_sel_spawned = false

func _on_pressed_57(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 57
		indicator_sel_spawned = false

func _on_pressed_58(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 58
		indicator_sel_spawned = false

func _on_pressed_59(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 59
		indicator_sel_spawned = false

func _on_pressed_60(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 60
		indicator_sel_spawned = false

func _on_pressed_61(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 61
		indicator_sel_spawned = false

func _on_pressed_62(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 62
		indicator_sel_spawned = false

func _on_pressed_63(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 63
		indicator_sel_spawned = false

func _on_pressed_64(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if event.is_action_pressed("l_click"):
		selected = 64
		indicator_sel_spawned = false
