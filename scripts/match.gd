extends Control

@onready var board_places: Control = $"Board Places"
@onready var highlighting: Control = $Highlighting
@onready var pawn_b: Node2D = $PawnB

@export var turn := true

const INDICATOR_POSSIBLE = preload("uid://jwcesd0w5er")
const INDICATOR_SELECTED = preload("uid://6cjjdud1fvr")
const BISHOPB = preload("uid://cbbpyg0o6am7f")
const KINGB = preload("uid://csxjs22db2fwk")
const KNIGHTB = preload("uid://78x7unrttfjs")
const PAWNB = preload("uid://dtp3o7niklaab")
const QUEENB = preload("uid://pyx0jk6vqvl3")
const ROOKB = preload("uid://wu7hjhsnwt6q")
const BISHOP = preload("uid://dn4wx5exxkd6j")
const KING = preload("uid://b1yxhruleaevk")
const KNIGHT = preload("uid://dopoqmcy33btu")
const PAWN = preload("uid://c248glb1xysec")
const QUEEN = preload("uid://8awts0j264pv")
const ROOK = preload("uid://ddt470jlxupw3")

var selected: int
var selected_or_not: bool
var piece_selected: String
var indicator_sel_spawned: bool
var moves_calculated := false

var all_pieces = {
	1 : ROOKB,
	2 : KNIGHTB,
	3 : BISHOPB,
	4 : QUEENB,
	5 : KINGB,
	6 : BISHOPB,
	7 : KNIGHTB,
	8 : ROOKB,
	9 : PAWNB,
	10 : PAWNB,
	11 : PAWNB,
	12 : PAWNB,
	13 : PAWNB,
	14 : PAWNB,
	15 : PAWNB,
	16 : PAWNB,
	17 : PAWN,
	18 : PAWN,
	19 : PAWN,
	20 : PAWN,
	21 : PAWN,
	22 : PAWN,
	23 : PAWN,
	24 : PAWN,
	25 : ROOK,
	26 : KNIGHT,
	27 : BISHOP,
	28 : QUEEN,
	29 : KING,
	30 : BISHOP,
	31 : KNIGHT,
	32 : ROOK,
}

var positions = {
	1 : 1,
	2 : 2,
	3 : 3,
	4 : 4,
	5 : 5,
	6 : 6,
	7 : 7,
	8 : 8,
	9 : 9,
	10 : 10,
	11 : 11,
	12 : 12,
	13 : 13,
	14 : 14,
	15 : 15,
	16 : 16,
	20 : 52,
	21 : 53,
	22 : 54,
	23 : 55,
	24 : 56,
	25 : 57,
	26 : 58,
	27 : 59,
	28 : 60,
	29 : 61,
	30 : 62,
	31 : 63,
	32 : 64
}

func _ready() -> void:
	spawn_pieces()
	await get_tree().create_timer(5).timeout

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("l_click"):
		for i in get_tree().get_nodes_in_group("indicators"):
			i.queue_free()
	if selected > 0 and indicator_sel_spawned:
		if board_places.get_child(selected - 1).get_children() != []:
			if board_places.get_child(selected - 1).get_child(0).is_in_group("white"):
				await get_tree().create_timer(0.01).timeout
				highlight_selected_piece()
	if selected > 0 and !moves_calculated:
		var key = get_key_from_value(positions, selected)
		if key != 0 and key > 16:
			get_legal_moves(key)

func spawn_pieces() -> void:
	await get_tree().create_timer(0.1).timeout
	add_piece(1, 1)
	add_piece(32, 64)
	await get_tree().create_timer(0.1).timeout
	add_piece(2, 2)
	add_piece(31, 63)
	await get_tree().create_timer(0.1).timeout
	add_piece(3, 3)
	add_piece(30, 62)
	await get_tree().create_timer(0.1).timeout
	add_piece(4, 4)
	add_piece(29, 61)
	await get_tree().create_timer(0.1).timeout
	add_piece(5, 5)
	add_piece(28, 60)
	await get_tree().create_timer(0.1).timeout
	add_piece(6, 6)
	add_piece(27, 59)
	await get_tree().create_timer(0.1).timeout
	add_piece(7, 7)
	add_piece(26, 58)
	await get_tree().create_timer(0.1).timeout
	add_piece(8, 8)
	add_piece(25, 57)
	await get_tree().create_timer(0.1).timeout
	for i in range(8):
		add_piece(9, 9 + i)
		add_piece(21, 56 - i)
		await get_tree().create_timer(0.1).timeout

func get_key_from_value(dict, value) -> int:
	for key in dict:
		if dict[key] == value:
			return key
	return 0

func move_piece(piece_number, new_position) -> void:
	var current_position = positions[piece_number]
	var instance = all_pieces[piece_number].instantiate()
	var square = board_places.get_child(new_position - 1)
	square.add_child(instance)
	positions[piece_number] = new_position
	board_places.get_child(current_position - 1).get_child(0).queue_free()
	turn = !turn

func add_piece(number, new_position) -> void:
	var instance = all_pieces[number].instantiate()
	var square = board_places.get_child(new_position - 1)
	square.add_child(instance)

func highlight_selected_piece() -> void:
	var instance  = INDICATOR_SELECTED.instantiate()
	var square = highlighting.get_child(selected - 1)
	square.add_child(instance)
	instance.add_to_group("indicators")
	indicator_sel_spawned = false
	moves_calculated = false

func get_legal_moves(number) -> Array:
	print("here")
	moves_calculated = true
	var possible_moves := []
	if all_pieces[number] == PAWN:
		possible_moves = [positions[number - 8], positions[number - 16]]
		if board_places.get_child(positions[number - 7]).get_children() != null:
			possible_moves.append(positions[number - 7])
		if board_places.get_child(positions[number - 9]).get_children() != null:
			possible_moves.append(positions[number - 9])
	elif all_pieces[number] == KNIGHT:
		pass
	elif all_pieces[number] == ROOK:
		pass
	elif all_pieces[number] == BISHOP:
		pass
	elif all_pieces[number] == QUEEN:
		pass
	if all_pieces[number] == KING :
		pass
	print(possible_moves)
	return possible_moves

# CLICKSSS #

func _on_pressed_1(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 1
		indicator_sel_spawned = true

func _on_pressed_2(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 2
		indicator_sel_spawned = true

func _on_pressed_3(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 3
		indicator_sel_spawned = true

func _on_pressed_4(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 4
		indicator_sel_spawned = true

func _on_pressed_5(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 5
		indicator_sel_spawned = true

func _on_pressed_6(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 6
		indicator_sel_spawned = true

func _on_pressed_7(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 7
		indicator_sel_spawned = true

func _on_pressed_8(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 8
		indicator_sel_spawned = true

func _on_pressed_9(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 9
		indicator_sel_spawned = true

func _on_pressed_10(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 10
		indicator_sel_spawned = true

func _on_pressed_11(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 11
		indicator_sel_spawned = true

func _on_pressed_12(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 12
		indicator_sel_spawned = true

func _on_pressed_13(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 13
		indicator_sel_spawned = true

func _on_pressed_14(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 14
		indicator_sel_spawned = true

func _on_pressed_15(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 15
		indicator_sel_spawned = true

func _on_pressed_16(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 16
		indicator_sel_spawned = true

func _on_pressed_17(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 17
		indicator_sel_spawned = true

func _on_pressed_18(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 18
		indicator_sel_spawned = true

func _on_pressed_19(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 19
		indicator_sel_spawned = true

func _on_pressed_20(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 20
		indicator_sel_spawned = true

func _on_pressed_21(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 21
		indicator_sel_spawned = true

func _on_pressed_22(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 22
		indicator_sel_spawned = true

func _on_pressed_23(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 23
		indicator_sel_spawned = true

func _on_pressed_24(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 24
		indicator_sel_spawned = true

func _on_pressed_25(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 25
		indicator_sel_spawned = true

func _on_pressed_26(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 26
		indicator_sel_spawned = true

func _on_pressed_27(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 27
		indicator_sel_spawned = true

func _on_pressed_28(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 28
		indicator_sel_spawned = true

func _on_pressed_29(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 29
		indicator_sel_spawned = true

func _on_pressed_30(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 30
		indicator_sel_spawned = true

func _on_pressed_31(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 31
		indicator_sel_spawned = true

func _on_pressed_32(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 32
		indicator_sel_spawned = true

func _on_pressed_33(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 33
		indicator_sel_spawned = true

func _on_pressed_34(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 34
		indicator_sel_spawned = true

func _on_pressed_35(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 35
		indicator_sel_spawned = true

func _on_pressed_36(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 36
		indicator_sel_spawned = true

func _on_pressed_37(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 37
		indicator_sel_spawned = true

func _on_pressed_38(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 38
		indicator_sel_spawned = true

func _on_pressed_39(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 39
		indicator_sel_spawned = true

func _on_pressed_40(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 40
		indicator_sel_spawned = true

func _on_pressed_41(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 41
		indicator_sel_spawned = true

func _on_pressed_42(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 42
		indicator_sel_spawned = true

func _on_pressed_43(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 43
		indicator_sel_spawned = true

func _on_pressed_44(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 44
		indicator_sel_spawned = true

func _on_pressed_45(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 45
		indicator_sel_spawned = true

func _on_pressed_46(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 46
		indicator_sel_spawned = true

func _on_pressed_47(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 47
		indicator_sel_spawned = true

func _on_pressed_48(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 48
		indicator_sel_spawned = true

func _on_pressed_49(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 49
		indicator_sel_spawned = true

func _on_pressed_50(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 50
		indicator_sel_spawned = true

func _on_pressed_51(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 51
		indicator_sel_spawned = true

func _on_pressed_52(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 52
		indicator_sel_spawned = true

func _on_pressed_53(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 53
		indicator_sel_spawned = true

func _on_pressed_54(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 54
		indicator_sel_spawned = true

func _on_pressed_55(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 55
		indicator_sel_spawned = true

func _on_pressed_56(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 56
		indicator_sel_spawned = true

func _on_pressed_57(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 57
		indicator_sel_spawned = true

func _on_pressed_58(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 58
		indicator_sel_spawned = true

func _on_pressed_59(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 59
		indicator_sel_spawned = true

func _on_pressed_60(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 60
		indicator_sel_spawned = true

func _on_pressed_61(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 61
		indicator_sel_spawned = true

func _on_pressed_62(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 62
		indicator_sel_spawned = true

func _on_pressed_63(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 63
		indicator_sel_spawned = true

func _on_pressed_64(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if !turn: return
	if event.is_action_pressed("l_click"):
		selected = 64
		indicator_sel_spawned = true
