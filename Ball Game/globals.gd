extends Node
var Score = 0
var Level = 0
var Levels = ["res://TutorialLevel.tscn","res://Level1.tscn","res://Level2.tscn","res://Level3.tscn","res://Level4.tscn","res://Level5.tscn", "res://Level6.tscn", "res://Level7.tscn", "res://Level8.tscn", "res://Level9.tscn", "res://FinalLevel.tscn"]
#Levels must contain the string of the path for every level so that the player can load them upon reaching an exit
var MusicPos = 0.0

var ScoreGainedThisLevel = 0
