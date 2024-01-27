extends Node

signal minigame_announce(text:String)
signal minigame_start()
signal minigame_won()
signal minigame_lost()
signal minigame_ready_for_next()

signal minigame_timer_timeout()
signal minigame_timer_init(time:float)
signal minigame_timer_stop()

#region Monch
signal monch_successful(monchable:Food)
signal monch_failed()
#endregion
