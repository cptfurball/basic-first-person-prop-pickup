# Godot First Person Basic Pickup (physics based) 

DEMO: https://youtu.be/wTyDLJK8Mww

Controls
--------

Movement:
- W - Move forward
- S - Move backward
- A - Move left
- D - Move right
- Left Ctrl (hold/toggle) - Crouc

Pick up:
- E (toggle) - Pickup object
- T + Mouse move (while holding an object) - Rotate object in space
- Left click (while holding an object) - Throw object

How to use the pickup?
----------------------
To allow and object to be picked up, you will need to create the rigid body object using the `LightProp` custom node.
Only objects using this node will be allowed to be picked up.

The rigid body to be picked up will react to its surroundings. Blocked by a wall? It won't budge. Try anyway? It will automatically drop the object on the floor.

If you do not need the player, you can swap it out with your own player controller. But reattach the `Container` and the `Crosshair` node provided in this project as it serves as a way to mount and detect rigid body. Just make sure all the referenced nodes in all the scripts are referenced correctly according to your own hierarchy.

Whats fun?
----------
Swing the object and release it and the object will be carry on with its momentum.

What is not working?
--------------------
- The rigid body weight will not influence the way it is picked up but only the throw distance.

Want to buy me a coffee?
--------------------------
Patreon: https://www.patreon.com/cptfurball