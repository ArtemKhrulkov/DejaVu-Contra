extends Node2D

func _ready():
	pass # Replace with function body.


const ItemTypes = {
	Health = 1,
	GrenadeLauncher = 2,
	Gatling = 3
}

func GetBase():
	return get_parent().get_parent().get_parent().get_parent().get_parent();
	
func GetCommonInventory():
	return GetBase().get_node("CommonInventory");
	
func GetItem(item):
	if item == ItemTypes.Health:
		GetCommonInventory().AddHp(1);
	if item == ItemTypes.GrenadeLauncher:
		get_parent().get_node("Gun").CoolDown = 1000;
		get_parent().get_node("Gun").XImpulse = 300;
		get_parent().get_node("Gun").YImpulse = 300;
		get_parent().get_node("Gun").Radius = 100;
	if item == ItemTypes.Gatling:
		get_parent().get_node("Gun").CoolDown = 50;
		get_parent().get_node("Gun").XImpulse = 1000;
		get_parent().get_node("Gun").YImpulse = 100;
		get_parent().get_node("Gun").Radius = 5;
