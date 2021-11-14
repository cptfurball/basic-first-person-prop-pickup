extends Spatial


const KEY_INTERACT: String = 'interact'


# Nodes
onready var crosshair_ray_cast = get_node('../Crosshair')


# Runtime 
var prop: LightProp


func _process(_delta):
	# This is to avoid ray cast to detect another object when there
	# is already an object on hand.
	crosshair_ray_cast.enabled = !prop
	
	set_prop()


# Detects player pickup input.
func set_prop() -> void:
	if Input.is_action_just_pressed(KEY_INTERACT):
		var object = crosshair_ray_cast.get_collider()

		if object is LightProp and !prop:
			prop = object
			prop.attach(self)
		elif prop is LightProp:
			prop.detach()
			prop = null

	if prop and prop.prop_container != self:
		prop = null


