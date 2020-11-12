extends Spatial

var tree_scale = 2.5
var tree_distance = 500
var num_trees

var img = Image.new()
var trees = []
var rng = RandomNumberGenerator.new()
onready var player = get_node("Player")
var treetypes = []
onready var navmesh = get_node("Navigation/NavigationMeshInstance/")
const tree1 = preload("res://Assets/Orignial Forest/Tree1/Tree1.tscn")
const tree2 = preload("res://Assets/Orignial Forest/Tree2/Tree2.tscn")
const tree3 = preload("res://Assets/Orignial Forest/Tree3/Tree3.tscn")
const tree4 = preload("res://Assets/Orignial Forest/Tree4/Tree4.tscn")

func _ready():
	treetypes.append(tree1)
	treetypes.append(tree2)
	treetypes.append(tree3)
	treetypes.append(tree4)
	img.load("res://Scripts/paths.jpg")
	img.lock()
	for i in range(8000):
		find_tree()
	for tree in trees:
		print('adding tree')
		var instancedtree = treetypes[tree[1]].instance()
		instancedtree.add_to_group("tree")
		print(tree[0])
		instancedtree.translate(tree[0])
		navmesh.add_child(instancedtree)
	img.save_png("res://outlocked.png")

func draw_circle(x, y, radius, color):
	var magnitude = radius * radius
	for i in range(-radius, radius):
		for j in range(-radius, radius):
			if(j*j) + (i*i) <= magnitude:
				if (i + y) < img.get_height() and (j + x) < img.get_width():
					if (i + y) >= 0 and (j + x) >= 0:
						img.set_pixel(j + x, i + y, color)

func find_tree():
	var x = 0
	var y = 0
	while true:
		x = rng.randi_range(0, img.get_width()-1)
		y = rng.randi_range(0, img.get_height()-1)
		if img.get_pixel(x ,y)[0] > rng.randf():
			draw_circle(x, y, 7, Color(0, 1, 1))
			x = (x/tree_scale) - (img.get_width()/(tree_scale * 2))
			y = (y/tree_scale) - (img.get_height()/(tree_scale * 2))
			var treetype = rng.randi_range(0, len(treetypes) - 1)
			trees.append([Vector3(x, 0, y), treetype])
			break

				
