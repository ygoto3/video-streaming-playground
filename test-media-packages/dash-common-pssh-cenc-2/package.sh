mkdir -p temp
rm -rf package

mp4fragment ../source/source.mp4 temp/fragmented.mp4

key=`cat ../source/keys/key.txt`
kid=`cat ../source/keys/kid.txt`

mp4encrypt --method MPEG-CENC \
  --key 2:$key:random \
  --property 2:KID:$kid \
  --global-option mpeg-cenc.eme-pssh:true \
  temp/fragmented.mp4 \
  temp/encrypted.mp4

mp4dash --exec-dir . \
  -o package \
  --mpd-name manifest.mpd \
  --use-segment-list \
  --eme-signaling=pssh-v1 \
  --encryption-cenc-scheme=cenc \
  --clearkey \
  temp/encrypted.mp4

rm -rf temp

