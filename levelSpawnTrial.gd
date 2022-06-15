extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var animation : Animation
export var ship : PackedScene
export var curve : Curve2D
# Called when the node enters the scene tree for the first time.
func _ready():
	var sped = 1
	var newShip := ship.instance();
	newShip.connect("switchPaths", get_child(3), "switch_path")
	newShip.connect("FinishedTransit", get_child(3), "put_node_on_path")
	get_child(3).get_node("line_right_side").add_child(newShip)
	var length : float = curve.get_baked_length()
	print("baked length for line : " + String(length))
	var pixelsPerSecond = length / 10.0
	if(pixelsPerSecond > 100):
		sped = (pixelsPerSecond / 100)
		newShip.initialize_enemy(animation, 1 / sped);
	if(pixelsPerSecond < 100):
		sped = 100 / pixelsPerSecond
		newShip.initialize_enemy(animation, 1 * sped);
	print("speed of line" + String(sped))

