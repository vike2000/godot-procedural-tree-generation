@tool
extends Node3D

# https://github.com/abiusx/L3D

# alphabet:
# +: turn right
# -: turn left
# &: pitch down
# ^: pitch up
# <: roll left /
# >: roll right \
# F: create branch and move forward
# [: push a new transformation onto the stack
# ]: pop a transformation from the stack 

const X := Vector3.RIGHT
const Y := Vector3.UP
const Z := Vector3.BACK

# must be an LSystem
@export var l_system: Resource

@export var start_length: float = 20
@export var length_factor: float = .9
@export var length_variance: float = .1
@export var start_thickness: float = 1 # (float, 0, 100)
@export var thickness_factor: float = 1

@export_range(0, 360) var min_rotation = 15
@export_range(0, 360) var max_rotation = 35

@export var colour: Color = Color(1, 1, 1, 1)

@export var branch_num_sides = 5 # (int, 3, 20)

# must be a LeafSettings
@export var leaf_settings: Resource

@export var random_seed: int = 0

@export var gen: bool: set = do_gen

var branches: Array


func _ready() -> void:
	generate()


func generate() -> void:
	if not l_system is LSystem: assert(l_system is LSystem, 'seeing type '+str(typeof(l_system))+('' if typeof(l_system)!=TYPE_OBJECT else ' ('+l_system.get_type()+')')+' for l_system that should be a resource of type LSystem')
	if not l_system is LSystem: assert(leaf_settings is LeafSettings, 'seeing type '+str(typeof(leaf_settings))+('' if typeof(leaf_settings)!=TYPE_OBJECT else ' ('+leaf_settings.get_type()+')')+' for leaf_settings that should be a resource of type LeafSettings')
	seed(random_seed)
	
	var turtle: Turtle = Turtle.new()
	var sentence: String = l_system.generate()
	
	var length: float = start_length
	var thickness: float = start_thickness
	
	for character in sentence:
		match character:
			'F':
				turtle.create_branch(length, length_variance, thickness, colour)
			'+':
				turtle.rotate(X, randf_range(min_rotation, max_rotation))
			'-':
				turtle.rotate(X, -randf_range(min_rotation, max_rotation))
			'&':
				turtle.rotate(Z, randf_range(min_rotation, max_rotation))
			'^':
				turtle.rotate(Z, -randf_range(min_rotation, max_rotation))
			'<':
				turtle.rotate(Y, randf_range(min_rotation, max_rotation))
			'>':
				turtle.rotate(Y, -randf_range(min_rotation, max_rotation))
			'[':
				turtle.push()
				length *= length_factor
				thickness *= thickness_factor
			']':
				turtle.pop()
				length /= length_factor
				thickness /= thickness_factor
	
	if has_node('GeneratedTreeMesh'):
		$GeneratedTreeMesh.free()
	
	var tree: Root = turtle.get_tree()
	var mesh: MeshInstance3D = tree.generate_mesh(branch_num_sides, start_thickness, colour, leaf_settings)
	mesh.set_name('GeneratedTreeMesh')
	add_child(mesh)
	

func do_gen(_b: bool) -> void:
	generate()
