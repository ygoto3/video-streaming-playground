mkdir temp package

ffmpeg -i ../source/source.mp4 -c:a copy \
  -vf "scale=-2:480" \
  -c:v libx264 -profile:v main -level:v 3.1 \
  -x264-params scenecut=0:open_gop=0:min-keyint=72:keyint=72 \
  -minrate 1000k -maxrate 1000k -bufsize 1000k -b:v 1000k \
  -y temp/480p.mp4

ffmpeg -i ../source/source.mp4 -c:a copy \
  -vf "scale=-2:360" \
  -c:v libx264 -profile:v baseline -level:v 3.0 \
  -x264-params scenecut=0:open_gop=0:min-keyint=72:keyint=72 \
  -minrate 600k -maxrate 600k -bufsize 600k -b:v 600k \
  -y temp/360p.mp4

packager \
  'in=temp/360p.mp4,stream=audio,init_segment=package/audio/init.mp4,segment_template=package/audio/$Number$.m4s' \
  'in=temp/360p.mp4,stream=video,init_segment=package/video/360p/init.mp4,segment_template=package/video/360p/$Number$.m4s' \
  'in=temp/480p.mp4,stream=video,init_segment=package/video/480p/init.mp4,segment_template=package/video/480p/$Number$.m4s' \
  --hls_master_playlist_output package/orig_playlist.m3u8 \
  --generate_static_live_mpd --mpd_output package/orig_manifest.mpd

python manipulate.py

mkdir package/original
mkdir package/redundant

cp -r package/audio package/redundant
cp -r package/video package/redundant
mv package/audio package/original
mv package/video package/original
cp package/stream_* package/redundant
mv package/stream_* package/original

for i in 5 6 7
do
  rm package/original/audio/$i.m4s
  rm package/original/video/360p/$i.m4s
  rm package/original/video/480p/$i.m4s
done

rm -rf temp
