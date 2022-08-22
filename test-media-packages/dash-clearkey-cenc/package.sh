mkdir -p package

kid=`cat ../source/keys/kid.txt`
key=`cat ../source/keys/key.txt`

pssh=`pssh-box.py \
  --system-id e2719d58a985b3c9781ab030af78d30e \
  --key-id $kid \
  --hex`

packager \
  in=../source/source.mp4,stream=audio,output=package/audio/audio.mp4,drm_label=AUDIO \
  in=../source/source.mp4,stream=video,output=package/video/video.mp4,drm_label=VIDEO \
  --mpd_output package/manifest.mpd \
  --protection_scheme cenc \
  --clear_lead 0 \
  --enable_raw_key_encryption \
  --pssh $pssh \
  --keys label=VIDEO:key_id=$kid:key=$key,label=AUDIO:key_id=$kid:key=$key \

