mkdir package

packager \
  in=../source/source.mp4,stream=audio,output=package/audio/audio.mp4 \
  in=../source/source.mp4,stream=video,output=package/video/video.mp4 \
  --hls_master_playlist_output package/temp_playlist.m3u8

