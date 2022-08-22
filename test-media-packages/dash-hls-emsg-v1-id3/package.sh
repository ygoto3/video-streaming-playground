mkdir -p temp package

packager \
  'in=../source/source.mp4,stream=audio,init_segment=package/audio/init.mp4,segment_template=package/audio/segment_$Number$.m4s' \
  'in=../source/source.mp4,stream=video,init_segment=package/video/init.mp4,segment_template=package/video/segment_$Number$.m4s' \
  --generate_static_live_mpd \
  --mpd_output package/manifest.mpd \
  --hls_master_playlist_output package/playlist.m3u8

for i in  1 2 3
do

  ts=90000
  let pt=($i-1)*7*$ts
  emsg -o temp/emsg-$i.atom --timescale $ts --presentation_time $pt --event_duration 180000 -i 0 -s https://aomedia.org/emsg/ID3 --value 1 -m "emsg message data $i"

  mp4extract styp package/video/segment_$i.m4s temp/styp.atom
  mp4extract sidx package/video/segment_$i.m4s temp/sidx.atom
  mp4extract moof package/video/segment_$i.m4s temp/moof.atom
  mp4extract mdat package/video/segment_$i.m4s temp/mdat.atom
  
  mp4edit \
    --insert :temp/sidx.atom:1 \
    --insert :temp/emsg-$i.atom:2 \
    --insert :temp/moof.atom:3 \
    --insert :temp/mdat.atom:4 \
    temp/styp.atom \
    package/video/segment_$i.m4s

done

python manifest_manipulate.py

rm -rf temp
