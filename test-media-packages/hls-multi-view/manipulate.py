import m3u8

variant_m3u8 = m3u8.load('./package/temp_playlist.m3u8')

altVideo: m3u8.model.Media = m3u8.model.Media(
    uri='stream_1.m3u8',
    type='VIDEO',
    group_id='low',
    name='Main',
    base_uri=variant_m3u8.media[0].base_uri
)
variant_m3u8.add_media(altVideo)

print(variant_m3u8)

for playlist in variant_m3u8.playlists:
    media: m3u8.model.Media = playlist.media
    media.append(altVideo)

print(variant_m3u8.dump('./package/playlist.m3u8'))