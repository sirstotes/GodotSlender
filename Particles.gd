extends Particles

export var rows = 200 setget set_rows, get_rows
export var spacing = 0.5 setget set_spacing, get_spacing

func update_aabb():
	var size = rows * spacing
	visibility_aabb = AABB(Vector3(-0.5 * size, 0.0, -0.5 * size), Vector3(size, 1.2, size))

func set_rows(new_rows):
	rows = new_rows
	update_aabb()
	amount = rows * rows
	if process_material:
		process_material.set_shader_param("rows", new_rows)
	
func get_rows():
	return rows	
	
func set_spacing(new_spacing):
	spacing = new_spacing
	update_aabb()
	amount = spacing * spacing
	if process_material:
		process_material.set_shader_param("spacing", new_spacing)
	
func get_spacing():
	return spacing	
	
func _ready():
	set_rows(rows)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var viewport = get_viewport()
	var camera = viewport.get_camera()
	
	var pos = camera.global_transform.origin
	pos.y = 0.0
	global_transform.origin = pos
