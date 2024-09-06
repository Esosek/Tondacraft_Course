class_name Enemy
extends CharacterBody3D

@export var health: int
@export var damage: int
@export var speed: float
@export var time_between_attack := 2.0 # jak často enemy útočí
@export var animation_player: AnimationPlayer

var next_attack := 0.0 # slouží pro měření času do dalšího útoku

var player: Player

func _ready():
	player = get_tree().get_first_node_in_group("PlayerGroup")
	if animation_player == null:
		printerr(name, ": Missing AnimationPlayer ref")

func attack(animation_name = ""):
	if next_attack <= 0: # Kontrola jestli může znovu útočit
		print(name + " attacks")
		player.take_damage(damage)
		next_attack = time_between_attack
		
		if animation_player and animation_name != "":
			animation_player.play(animation_name)

func _process(delta):
	if next_attack > 0:
		next_attack -= delta
