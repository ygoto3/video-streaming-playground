mkdir -p package

packager \
  in=../source/source.mp4,stream=audio,output=package/audio/audio.mp4 \
  in=../source/source.mp4,stream=video,output=package/video/video.mp4 \
  --mpd_output package/manifest.mpd \
  --hls_master_playlist_output package/playlist.m3u8 \
  --protection_scheme cbcs \
  --enable_widevine_encryption \
  --clear_lead 0 \
  --key_server_url https://license.uat.widevine.com/cenc/getcontentkey/widevine_test \
  --content_id 7465737420636f6e74656e74206964 \
  --signer widevine_test \
  --aes_signing_key 1ae8ccd0e7985cc0b6203a55855a1034afc252980e970ca90e5202689f947ab9 \
  --aes_signing_iv d58ce954203b7c9a9a9d467f59839249

