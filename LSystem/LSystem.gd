@tool
class_name LSystem
extends AACustomResource


# the starting string
@export var axiom: String
# each rule must be an AARule
@export var rules: Array[Resource]
@export var num_generations = 5 # (int, 1, 20)


func generate() -> String:
	if not rules is Array[Resource]: assert(rules is Array[Resource], 'seeing type '+str(typeof(rules))+' for rules that should be of type Array[Resource]')
	assert(len(rules) > 0, "at least one rule required")
	assert(len(axiom) > 0, "axiom required")
	for rule in rules:
		assert(rule is Rule, "rules must be resource of type Rule")

	var sentence: String = axiom

	for i in (num_generations):
		var new_sentence := ""
		for character in sentence:
			var found := false
			for rule in rules:
				if rule.predecessor == character:
					new_sentence += rule.successor
					found = true
					break
			if not found:
				new_sentence += character

		sentence = new_sentence

	return sentence
