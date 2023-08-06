#!/bin/bash
rm -r ./build-dir
rm -r ./.flatpak-builder
flatpak-builder --user --install --force-clean build-dir org.alaska.piper.yml