extends Node2D


func put_node_on_path(node : Node, pathName: String, rewinding : bool):
	var sped = 1
	var length = get_node(pathName).curve.get_baked_length()
	print("baked " + pathName + " Length : " + String(length))
	var pixelsPerSecond = length / 10.0
	if(pixelsPerSecond > 100):
		sped = (pixelsPerSecond / 100)
		node.set_speed(sped)
	if(pixelsPerSecond < 100):
		print("slower")
		sped = 100 / pixelsPerSecond
		node.set_speed(sped)
	print("speed of "+ pathName + String(sped))
	node.unit_offset = 0
	node.offset = 0
	node.play_movement(rewinding)
	get_node(pathName).add_child(node)


func switch_path(node : Node, position : Vector2, pathName : String, rewinding : bool):
	var sped = 1
	var firstPoint : Vector2
	if(pathName.count("connection") == 0):
		firstPoint = get_node(pathName).curve.get_point_position(0)
	else:
		firstPoint = get_node(pathName.substr(node.name.length()+" connection to ".length())).curve.get_point_position(0)
	print(firstPoint)
	var array :Array = [position, firstPoint]
	if(firstPoint != position):
		if(get_node(pathName) == null):
			make_new_path(array, pathName)
		node.waitForTransition(pathName)
	put_node_on_path(node, pathName, rewinding)


func make_new_path(positionArray : Array, newPathName : String):
	var newPath := Path2D.new()
	newPath.name = newPathName
	self.add_child(newPath)
	for point in positionArray : 
		newPath.curve.add_point(point)
		print(point)
