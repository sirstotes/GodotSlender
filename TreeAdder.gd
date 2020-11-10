extends Spatial
export var type = 1
export var random = true
func _ready():
	randomize()
	if random:
		type = randi()%31+1
	remove_child($remove)
	var new : Spatial = load("res://Objects/Trees/Tree"+String(type)+".tscn").instance()
	new.transform.origin = Vector3(0, 0, 0)
	new.rotate_y(randf()*PI)
	new.scale_object_local(Vector3(1.2+randf()*0.5, 1.2+randf()*0.5, 1.2+randf()*0.5))
	add_child(new)
	print(new)
