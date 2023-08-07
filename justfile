build:
	flatpak-builder --gpg-sign=705B7FCD12A5625D2A395876EC2F755C1C97BA71 --force-clean build-dir moe.amy.tts.yml 

run:
	flatpak run moe.amy.tts