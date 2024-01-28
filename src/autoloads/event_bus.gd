extends Node

signal minigame_announce(text:String)
signal minigame_start()
signal minigame_won()
signal minigame_lost()
signal minigame_ready_for_next()
signal minigame_cleanup()
signal minigame_cleanup_complete()

signal minigame_timer_timeout()
signal minigame_timer_init(time:float)
signal minigame_timer_stop()

signal main_menu_requested()

signal close_curtain()
signal open_curtain()
signal curtain_opened()
signal curtain_closed()

signal game_over()
signal show_game_over()
signal game_over_screen_ready()

#region Monch
signal monch_successful(monchable:Food)
signal monch_failed()
#endregion
