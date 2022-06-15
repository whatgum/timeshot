extends Sprite


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var enemyContainer : Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	enemyContainer = get_tree().get_nodes_in_group("EnemyContainer")[0]

func spawnEnemy(enemy : PackedScene):
	var newEnemyInstance := enemy.instance()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
