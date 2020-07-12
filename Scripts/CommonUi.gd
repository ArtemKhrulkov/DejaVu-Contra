extends CanvasLayer

export var Hp = 10;
export var Kills = 0;


var lastHp = -1;
var lastKills = -1;

onready var hpVapueLabel = $RightContainer/VBoxContainer/HBoxContainer/HPValue;
onready var killsVapueLabel = $RightContainer/VBoxContainer/HBoxContainer2/KillsValue;
onready var timeLabel = $RightContainer/VBoxContainer/Timer/Label;

onready var player1 = get_parent().get_node("ViewportContainer1/Viewport1/World/Player");
onready var player2 = get_parent().get_node("ViewportContainer2/Viewport2/World/Player");

func _ready():
	timeLabel.Start();
	pass # Replace with function body.


func _process(_delta):
	if lastHp != Hp:
		hpVapueLabel.text = str(Hp);
		lastHp = Hp;
	if lastKills != Kills:
		killsVapueLabel.text = str(Kills);
		lastKills = Kills;
	
	if player1.isWinner && player2.isWinner:
		timeLabel.Stop();
	
	timeLabel.text = timeLabel.GetTime()
	pass
