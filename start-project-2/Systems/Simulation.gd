extends Node

const BARRIER_ID := 1
const INVISIBLE_BARRIER_ID := 2

export var simulation_speed := 1.0 / 30.0

var _tracker := EntityTracker.new()

onready var _power_system := PowerSystem.new()
onready var _ground := $GameWorld/GroundTiles
onready var _entity_placer := $GameWorld/YSort/EntityPlacer
onready var _player := $GameWorld/YSort/Player
onready var _flat_entities := $GameWorld/FlatEntities


func _ready() -> void:
	$Timer.start(simulation_speed)
	_entity_placer.setup(_tracker, _ground, _flat_entities, _player)
	
	# Find all tile coordinates that use the purple barrier block
	var barriers: Array = _ground.get_used_cells_by_id(BARRIER_ID)
	# Replace each of those cells with the invisible barrier with collision
	for cellv in barriers:
		_ground.set_cellv(cellv, INVISIBLE_BARRIER_ID)


func _on_Timer_timeout() -> void:
	Events.emit_signal("systems_ticked", simulation_speed)
