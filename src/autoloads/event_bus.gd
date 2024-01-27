extends Node

signal minigame_announce(text:String)
signal minigame_start()
signal minigame_won()
signal minigame_lost()

signal minigame_timer_timeout()

#region Monch
signal monch_successful(monchable:Food)
signal monch_failed()
#endregion
