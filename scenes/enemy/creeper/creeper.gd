class_name Creeper
extends Enemy


# Called when the node enters the scene tree for the first time.
func _ready():
	super()
	print(health)
	attack()


# Godot volá každý frame. Používá se pro všechno kromě fyzikálního pohybu
# parametr delta je čas mezi framy a slouží pro konzistentní update.
func _process(_delta):
	#follow_player("Pronásleduji hráče")
	pass
	
# Godot volá každý frame. Používá se pro fyzikální pohyb
func _physics_process(_delta):
	pass

func follow_player(zprava: String):
	print(zprava)
