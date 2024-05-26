class_name LeafSettings
extends CustomResource


@export var frequency = .5 # (float, 0.001, 1)
@export var width: float = 1
@export var height: float = 1
# how far up the tree the branch needs to be to have leaves
@export var min_depth = 3 # (int, 1, 20)
@export var colour: Color = Color(0, 1, 0, 1)
