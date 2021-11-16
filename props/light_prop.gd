# Custom Node Name: LightProp
# Author: Capt.Furball
#
# LightProp is a behavior class for props which can be picked up
# by the player and carried around easily
extends RigidBody
class_name LightProp, "res://Assets/Icons/RigidBody3D.svg"

# This controls how much it will turn if it bumps into something.
# Change this to suit your needs.
const ANGULAR_DAMP: float = 10.0

# REQUIRED: Setup the Player, World, Prop collision layer.
# If you have different collision mask and layer setup. 
# please change this accordingly.
const CONTAINER_MASK_ATTACH_MODE: int = 6
const CONTAINER_MASK_DETACH_MODE: int = 7

# REQUIRED: Please include this key on your input map. It can be any key you want
const KEY_DETACH: String = 'interact' 
const DEFAULT_THROW_POWER: float = 5.0
const KEY_FIRE: String = 'fire'
const KEY_INSPECT: String = 'inspect'


# Exported (Never update this on runtime)
export(float, 0.0, 90.0, 0.05) var snap_velocity = 20.0
export(float, 0.0, 90.0, 0.05) var let_go_distance = 0.8
export(float, 0.0, 1.0, 0.05) var mouse_x_sensitivity = 0.1
export(float, 0.0, 1.0, 0.05) var mouse_y_sensitivity = 0.1

# Runtime
var prop_container: Node

func _input(event):
	if event is InputEventMouseMotion and prop_container and Input.is_action_pressed(KEY_INSPECT):
		# rotate the player body
		rotate_y(deg2rad(-event.relative.x * mouse_x_sensitivity))

		# rotate the camera on x axis (look up or down)
		rotate_x(deg2rad(-event.relative.y * mouse_y_sensitivity))


func _process(_delta):
	if prop_container:
		move()
		detach_and_throw()


# This method tries to move the prop towards the prop container origin.
# However, if it is colliding an object and the distance of the prop container
# is too far away, it will detach itself.
func move():
	# Calculates the direction of the prop container from the prop
	var direction: Vector3 = global_transform.origin.direction_to(prop_container.global_transform.origin).normalized()
	
	# Calculates the distance of the prop to the prop container
	var distance: float = global_transform.origin.distance_to(prop_container.global_transform.origin)
	
	# Moves the prop towards the prop container node.
	linear_velocity = direction * distance * snap_velocity;

	# If the object is too far away, release the object. This prevents the prop
	# from trying to clip through other objects.
	if get_colliding_bodies() and distance > let_go_distance:
		detach()


# This method will attempt to "attach" this prop to the causer.
# I use the word "attach" loosely here as it does not actually modify
# the node structure, but rather marks a node as a point of reference
# for positioning.
#
# This also disables the collision layer and collision mask.
#
# This method should be called by the causer.
func attach(causer: Node):
	collision_mask = CONTAINER_MASK_ATTACH_MODE
	prop_container = causer
	angular_damp = ANGULAR_DAMP


# The opposite of detach. This will reset the collision mask
# and the marked prop container.
#
# This method should be called by the causer.
func detach():
	collision_mask = CONTAINER_MASK_DETACH_MODE
	prop_container = null
	angular_damp = -1


# Throws the object to a certain direction the parent is facing
func detach_and_throw() -> void:
	if Input.is_action_just_pressed(KEY_FIRE):
		var throw_power = DEFAULT_THROW_POWER

		if 'throw_power' in prop_container:
			throw_power = prop_container.throw_power

		apply_central_impulse(-prop_container.global_transform.basis.z * throw_power)
		detach()
