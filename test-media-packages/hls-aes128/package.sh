mkdir -p package

openssl rand 16 > package/aes128.key

mp42hls \
  --index-filename package/playlist.m3u8 \
  --segment-filename-template package/segment-%d.ts \
  --encryption-key `xxd -ps package/aes128.key` \
  --encryption-key-uri aes128.key \
  ../source/source.mp4

