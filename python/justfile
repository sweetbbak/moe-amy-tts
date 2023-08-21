build:
	flatpak-builder --gpg-sign=705B7FCD12A5625D2A395876EC2F755C1C97BA71 --force-clean build-dir moe.amy.tts.yml 
install:
	flatpak-builder --force-clean build moe.amy.tts.yml --install --user
run:
	flatpak run moe.amy.tts
test:
	flatpak run --command=piper moe.amy.tts
	flatpak run --command=zenity moe.amy.tts
