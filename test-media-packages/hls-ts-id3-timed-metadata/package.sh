mkdir -p timed-metadata package

id3taggenerator -o timed-metadata/metadata001.id3 -t metadata001 --text-type TXXX
id3taggenerator -o timed-metadata/metadata002.id3 -t metadata002 --text-type TXXX
id3taggenerator -o timed-metadata/metadata003.id3 -t metadata003 --text-type TXXX

cat <<EOF > timed-metadata/id3.meta
5 id3 metadata001.id3
10 id3 metadata002.id3
15 id3 metadata003.id3
EOF

mediafilesegmenter \
  -f package \
  -i playlist.m3u8 \
  -t 5 \
  -M timed-metadata/id3.meta \
  ../source/source.mp4 \

rm -rf timed-metadata

