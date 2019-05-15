extends Node

# demo getting nodes from the scene tree
func _ready() -> void:
	print("All nodes in current scene:")
	var root = get_tree().get_root()
	print_nodes(root)
	
	print("Node this script is running on: " + self.name)
	
	var parent = get_parent()
	print("Parent of this node: " + parent.name)
	
	var parent2 = get_node("../Child2")
	print("Sibling retrieved via relative path: " + parent2.name)
	
	parent2 = get_node("/root/Grandparent/Parent1/Child2")
	print("Sibling retrieved via absolute path: " + parent2.name)
	
	var cousin = root.find_node("*ild3", true, false)
	print("Cousin retrieved via find_node(): " + cousin.name)
	
func print_nodes(node: Node, depth: int = 0) -> void:
	print(indent(depth) + node.name)
	for child in node.get_children():
		print_nodes(child, depth + 1)
		
func indent(length: int) -> String:
	var indent = ""
	for i in range(length):
		indent += " "
	return indent