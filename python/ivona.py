#!/bin/env python3
# import piper
from piper import PiperVoice
import sys
from pathlib import Path
import pyaudio

# import os
# import time
# import wave
# from typing import Any, Dict

model = "/home/sweet/ssd/ivona_tts/amy.onnx"
config = "/home/sweet/ssd/ivona_tts/amy.onnx.json"
# data_dir = os.getcwd()
# output_dir = os.getcwd()
# output_raw = True
# output_file = "./output"
# cuda = True
# cuda = False

model_path = Path(model)
if not model_path.exists():
    exit

voice = PiperVoice.load(model)
print(sys.getsizeof(voice))
# if output_raw:
# Read line-by-line
p = pyaudio.PyAudio()
stream = p.open(
    format=pyaudio.paInt16, channels=1, rate=22050, output=True, frames_per_buffer=1024
)

"""while True:
    for line in sys.stdin:
        line = line.strip()
        # if not line:
        #     continue

        # Write raw audio to stdout as its produced
        # audio_stream = voice.synthesize_stream_raw(line, **synthesize_args)
        if "EXIT" in line:
            break
        audio_stream = voice.synthesize_stream_raw(line)
        for audio_bytes in audio_stream:
            # sys.stdout.buffer.write(audio_bytes)
            # sys.stdout.buffer.flush()

            stream.write(audio_bytes)
        stream.stop_stream()
        stream.close()

p.terminate()
"""
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
