mkdir -p temp package/text

ffmpeg -i ../source/tear-of-steel_en.srt \
  -y package/text/en.vtt

ffmpeg -i ../source/tear-of-steel_fr.srt \
  -y package/text/fr.vtt

ffmpeg -i ../source/tear-of-steel_de.srt \
  -y package/text/de.vtt

packager \
  in=../source/source.mp4,stream=audio,output=package/audio/audio.mp4 \
  in=package/text/en.vtt,stream=text,lang=en,output=package/text/en.vtt,dash_roles=subtitle \
  in=package/text/fr.vtt,stream=text,lang=fr,output=package/text/fr.vtt,dash_roles=subtitle \
  in=package/text/de.vtt,stream=text,lang=de,output=package/text/de.vtt,dash_roles=subtitle \
  in=../source/source.mp4,stream=video,output=package/video/video.mp4 \
  --default_language en \
  --mpd_output package/manifest.mpd \
  --hls_master_playlist_output package/playlist.m3u8

rm -rf temp
