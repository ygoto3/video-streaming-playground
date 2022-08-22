mkdir -p temp package/text

packager \
  'in=../source/source.mp4,stream=audio,init_segment=package/audio/init.mp4,segment_template=package/audio/segment_$Number$.m4s' \
  'in=../source/source.mp4,stream=video,init_segment=package/video/init.mp4,segment_template=package/video/segment_$Number$.m4s' \
  --generate_static_live_mpd \
  --mpd_output package/manifest.mpd \
  --hls_master_playlist_output package/playlist.m3u8

mp4extract styp package/video/segment_1.m4s temp/styp.atom
mp4extract sidx package/video/segment_1.m4s temp/sidx.atom
mp4extract moof package/video/segment_1.m4s temp/moof.atom
mp4extract mdat package/video/segment_1.m4s temp/mdat.atom
cp ../source/emsg_v0.atom temp

mp4edit \
  --insert :temp/sidx.atom:1 \
  --insert :temp/emsg_v0.atom:2 \
  --insert :temp/moof.atom:3 \
  --insert :temp/mdat.atom:4 \
  temp/styp.atom \
  package/video/segment_1.m4s

python manifest_manipulate.py

rm -rf temp
