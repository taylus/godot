# GDScript and working with nodes demo
A very minimal demo that just prints some information about the current scene's nodes to the Output window:

```text
All nodes in current scene:
root
 Grandparent
  Parent1
   Child1
   Child2
  Parent2
   Child3
Node this script is running on: Child1
Parent of this node: Parent1
Sibling retrieved via relative path: Child2
Sibling retrieved via absolute path: Child2
Cousin retrieved via find_node(): Child3
```

Also demonstrates basic GDScript language features:
* Variables
* Functions and recursion
* Loops
* https://godotengine.org/article/optional-typing-gdscript

## References
* https://docs.godotengine.org/en/3.1/getting_started/step_by_step/scenes_and_nodes.html
* https://www.youtube.com/watch?v=WUARiOGSGKY&list=PLS9MbmO_ssyDk79j9ewONxV88fD5e_o5d&index=3
* https://docs.godotengine.org/en/3.1/getting_started/scripting/gdscript/gdscript_basics.html
