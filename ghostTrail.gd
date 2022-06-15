extends Sprite

var fadeaway := false

func startFade(pos : Vector2):
	self.global_position = pos
	fadeaway = true
	modulate.a = .5

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	if(fadeaway):
		modulate.a = lerp(modulate.a,0,.1)
		if(modulate.a < 0.01):
			modulate.a = 0
			fadeaway = false
