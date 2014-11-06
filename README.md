## Presentation
The slides in this repository was from a presentation held at Cocoaheads Stockholm on November 3rd, 2014.

## Script
This Ruby script shows how to transcode a video using ffmpeg and package it for HLS using tools provided by Apple.

### Disclaimer
The ffmpeg command in this script **will not produce the best possible video**. It's only a sample showing how to simply transcode a video for HLS using ffmpeg. Please refer to the ffmpeg documentation for more information on how to produce [H264 encoded video](https://trac.ffmpeg.org/wiki/Encode/H.264) and [AAC encoded audio](https://trac.ffmpeg.org/wiki/Encode/AAC).

### Requirements
* ffmpeg
* HTTP Live Streaming Tools (download from https://developer.apple.com/downloads/index.action)
