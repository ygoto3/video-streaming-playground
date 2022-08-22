mkdir -p package

kid=`cat ../source/keys/kid.txt`
key=`cat ../source/keys/key.txt`

xxd -r -p ../source/keys/key.txt package/key.bin

packager \
  in=../source/source.mp4,stream=audio,output=package/audio/audio.mp4,drm_label=AUDIO \
  in=../source/source.mp4,stream=video,output=package/video/video.mp4,drm_label=VIDEO \
  --mpd_output package/manifest.mpd \
  --hls_master_playlist_output package/playlist.m3u8 \
  --protection_scheme cenc \
  --clear_lead 0 \
  --enable_raw_key_encryption \
  --keys label=VIDEO:key_id=$kid:key=$key,label=AUDIO:key_id=$kid:key=$key \
  --hls_key_uri key.bin

