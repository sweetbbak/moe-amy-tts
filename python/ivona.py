#!/bin/env python3
from piper import PiperVoice
import sys
from pathlib import Path
import pyaudio
import os
import atexit


class TTS_Model:
    def __init__(self, model, config):
        self.model = model
        self.config = config


amy = TTS_Model(
    model="/home/sweet/ssd/ivona_tts/amy.onnx",
    config="/home/sweet/ssd/ivona_tts/amy.onnx.json",
)

emma = TTS_Model(
    model="/home/sweet/ssd/amy++/amy.onnx",
    config="/home/sweet/ssd/amy++/amy.onnx.json",
)

model = amy.model
config = amy.config
pipe = os.path.join(os.getcwd(), "pipe")
pipe = Path(pipe)

if not pipe.exists():
    os.mkfifo(pipe)

model_path = Path(model)
if not model_path.exists():
    print("Error: Model path does not exist.")
    exit()


@atexit.register
def cleanup():
    if pipe.exists():
        os.remove(pipe)


def daemon():
    voice = PiperVoice.load(model)
    p = pyaudio.PyAudio()
    stream = p.open(
        format=pyaudio.paInt16,
        channels=1,
        rate=22050,
        output=True,
        frames_per_buffer=1024,
    )
    while True:
        with open("pipe", "r") as fifo:
            data = fifo.read()
            data = data.strip()
            if "SIGEXIT9" in data:
                break
            audio_stream = voice.synthesize_stream_raw(data)
            for audio_bytes in audio_stream:
                # sys.stdout.buffer.write(audio_bytes)
                # sys.stdout.buffer.flush()
                stream.write(audio_bytes)
            sys.stdin.flush()

    stream.stop_stream()
    stream.close()

    p.terminate()


daemon()
