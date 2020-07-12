extends CanvasLayer

export var Hp = 10;
export var Kills = 0;


var lastHp = -1;
var lastKills = -1;

onready var hpVapueLabel = $RightContainer/VBoxContainer/HBoxContainer/HPValue;
onready var killsVapueLabel = $RightContainer/VBoxContainer/HBoxContainer2/KillsValue;

func _ready():
	pass # Replace with function body.


func _process(_delta):
	if lastHp != Hp:
		hpVapueLabel.text = str(Hp);
		lastHp = Hp;
	if lastKills != Kills:
		killsVapueLabel.text = str(Kills);
		lastKills = Kills;
	pass
