import vlc

instance = vlc.Instance()
player = instance.media_player_new()

media = instance.media_new("http://www.quirksmode.org/html5/videos/big_buck_bunny.mp4")
player.set_media(media)

player.play()
