extends Control

const GYRO_LABEL_TEXT: String = "Gyro: %s"
const ACCEL_LABEL_TEXT: String = "Accelerometer: %s"
const GRAVITY_LABEL_TEXT: String = "Gravity: %s"

onready var _gyroLabel: Label = get_node("MarginContainer/VBoxContainer/GyroLabel")
onready var _accelLabel: Label = get_node("MarginContainer/VBoxContainer/AccelerometerLabel")
onready var _gravityLabel: Label = get_node("MarginContainer/VBoxContainer/GravityLabel")
onready var _imageX: TextureRect = find_node("IconX")
onready var _imageY: TextureRect = find_node("IconY")
onready var _imageZ: TextureRect = find_node("IconZ")

func _process(delta: float) -> void:
	var gyroReading: Vector3 = Input.get_gyroscope()
	_gyroLabel.text = GYRO_LABEL_TEXT % gyroReading
	
	var accelReading: Vector3 = Input.get_accelerometer()
	_accelLabel.text = ACCEL_LABEL_TEXT % accelReading
	
	var gravity: Vector3 = Input.get_gravity()
	_gravityLabel.text = GRAVITY_LABEL_TEXT % gravity

	_imageX.set_rotation(accelReading.x)
	_imageY.set_rotation(accelReading.y)
	_imageZ.set_rotation(accelReading.z)