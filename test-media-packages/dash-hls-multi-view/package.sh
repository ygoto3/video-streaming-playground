mkdir temp package

packager \
  'in=../source/source.mp4,stream=audio,init_segment=package/audio/init.mp4,segment_template=package/audio/$Number$.m4s' \
  'in=../source/source.mp4,stream=video,dash_roles=main,init_segment=package/video_viewpoint1/init.mp4,segment_template=package/video_viewpoint1/$Number$.m4s' \
  'in=../source/source_subangle.mp4,stream=video,dash_roles=alternate,init_segment=package/video_viewpoint2/init.mp4,segment_template=package/video_viewpoint2/$Number$.m4s' \
  --generate_static_live_mpd \
  --hls_master_playlist_output package/playlist.m3u8 \
  --mpd_output package/manifest.mpd

rm -rf temp
