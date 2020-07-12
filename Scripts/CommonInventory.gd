extends Node2D

export var Hp = 10;
export var Kills = 0;

func AddHp(count):
	Hp = Hp + count;
	get_parent().get_node("CommonUi").Hp = Hp;
	
