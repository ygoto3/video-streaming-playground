mkdir package

packager \
  in=../source/source.mp4,stream=audio,output=package/audio/audio.mp4 \
  in=../source/source.mp4,stream=video,output=package/video/video.mp4 \
  --ad_cues '10;20;30' \
  --hls_master_playlist_output package/playlist.m3u8 \
  --mpd_output package/manifest.mpd

