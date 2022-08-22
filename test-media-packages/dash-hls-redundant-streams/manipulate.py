import xml.etree.ElementTree as ET
import m3u8
import copy

def manipulate_mpd():
    ET.register_namespace("", "urn:mpeg:dash:schema:mpd:2011")
    ET.register_namespace("xsi", "http://www.w3.org/2001/XMLSchema-instance")
    ns = {"m": "urn:mpeg:dash:schema:mpd:2011"}

    tree = ET.parse("./package/orig_manifest.mpd")

    mpd = tree.getroot()
    baseUrl = ET.Element("BaseURL")
    baseUrl.text = "./redundant/"
    mpd.insert(0, baseUrl)

    baseUrl = ET.Element("BaseURL")
    baseUrl.text = "./original/"

    mpd.insert(0, baseUrl)

    tree.write("package/manifest.mpd", "UTF-8", True)

def manipulate_m3u8():
    mvariant_playlist = m3u8.load("./package/orig_playlist.m3u8")
    media = mvariant_playlist.media
    playlists = mvariant_playlist.playlists

    for i in range(0, len(media)):
        original_media = media[i * 2]
        redundant_media = copy.deepcopy(original_media)
        original_media.uri = "original/" + original_media.uri
        redundant_media.uri = "redundant/" + redundant_media.uri
        redundant_media.group_id = "redundant-" + redundant_media.group_id
        media.insert(i * 2 + 1, redundant_media)

    for i in range(0, len(playlists)):
        original_playlist = playlists[i * 2]
        redundant_playlist = copy.deepcopy(original_playlist)

        original_playlist.uri = "original/" + original_playlist.uri

        redundant_playlist.uri = "redundant/" + redundant_playlist.uri
        for m in redundant_playlist.media:
            m.group_id = "redundant-" + m.group_id

        playlists.insert(i * 2 + 1, redundant_playlist)
   
    mvariant_playlist.dump("package/playlist.m3u8")

def main():
    manipulate_m3u8()
    manipulate_mpd()

if __name__ == "__main__":
    main()
