extends AudioStreamPlayer


func play_song(song:AudioStream) -> void:
	stream = song
	play()
