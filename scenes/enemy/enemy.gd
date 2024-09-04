class_name Enemy
extends CharacterBody3D

@export var health: int
@export var damage: int
@export var speed: float

var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("PlayerGroup")

func attack():
	print(name + " attacks")
