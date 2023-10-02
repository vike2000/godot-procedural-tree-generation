extends Node2D

# some L-systems:
# http://paulbourke.net/fractals/lsys/

# alphabet:
# F: create branch and move forward
# +: rotate right
# -: rotate left
# [: push a new transformation onto the stack
# ]: pop a transformation from the stack 

# must be an LSystem
@export var l_system: Resource

@export var start_length: int = 20
@export var length_factor: float = .5
@export var thickness = 1 # (int, 1, 100)

@export var min_rotation = 15 # (float, 0, 360)
@export var max_rotation = 35 # (float, 0, 360)

@export var colour: Color = Color(1, 1, 1, 1)

@export var random_seed: int = 0

var branches: Array


func _ready() -> void:
	generate()


func generate() -> void:
	assert(l_system is LSystem, "l_system must be a resource of type LSystem")
	seed(random_seed)
	
	var turtle: Turtle2D = Turtle2D.new()
	var sentence: String = l_system.generate()
	
	var length: float = start_length
	branches = []
	
	for character in sentence:
		match character:
			'F':
				branches.append(turtle.create_line(length))
			'+':
				turtle.rotate(randf_range(min_rotation, max_rotation))
			'-':
				turtle.rotate(-randf_range(min_rotation, max_rotation))
			'[':
				turtle.push()
				length *= length_factor
			']':
				turtle.pop()
				length /= length_factor


func _draw() -> void:
	for branch in branches:
		draw_line(branch.point1, branch.point2, colour, thickness)
