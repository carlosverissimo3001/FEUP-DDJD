class_name Spawner
extends Node2D

@export var player_scene: PackedScene
@export var player_ammount = 0

var spawned_players = 0
var spawn_offset = Vector2(50, 50)

var main_node
var hud_node

func _ready():
	$SpawnTimer.start()
	main_node = get_parent().get_parent()
	hud_node = main_node.get_node("HUD")

func _on_spawner_timer_timeout():
	if spawned_players >= player_ammount:
		$SpawnTimer.stop()
		return
	
	var player = player_scene.instantiate()
	var format = "Engineer_%d"
	player.name = format % spawned_players
	player.position += self.position + spawn_offset
	spawned_players += 1
	
	# update HUD
	hud_node._updatePlayers(spawned_players)
	
	get_parent().add_child(player)
