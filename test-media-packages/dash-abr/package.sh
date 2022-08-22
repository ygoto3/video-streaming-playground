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
  in=temp/360p.mp4,stream=audio,output=package/audio/audio.mp4 \
  in=temp/360p.mp4,stream=video,output=package/video/360p.mp4 \
  in=temp/480p.mp4,stream=video,output=package/video/480p.mp4 \
  --mpd_output package/manifest.mpd

rm -rf temp
