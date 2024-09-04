class_name Enemy
extends CharacterBody3D

@export var health: int
@export var damage: int
@export var speed: float
@export var time_between_attack := 2.0 # jak často enemy útočí

var next_attack := 0.0 # slouží pro měření času do dalšího útoku

var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("PlayerGroup")

func attack():
	if next_attack <= 0:
		print(name + " attacks")
		next_attack = time_between_attack

func _process(delta):
	if next_attack > 0:
		next_attack -= delta
