mkdir -p package

packager \
  in=../source/source.mp4,stream=audio,lang=en,output=package/audio/en.mp4,hls_group_id=audio,hls_name=ENGLISH,playlist_name=audio_en.m3u8 \
  in=../source/source_fr.mp4,stream=audio,lang=fr,output=package/audio/fr.mp4,hls_group_id=audio,hls_name=FRENCH,playlist_name=audio_fr.m3u8 \
  in=../source/source.mp4,stream=video,output=package/video/video.mp4,playlist_name=video.m3u8 \
  --default_language en \
  --hls_master_playlist_output package/playlist.m3u8
