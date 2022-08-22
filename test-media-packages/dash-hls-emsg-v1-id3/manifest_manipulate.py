import xml.etree.ElementTree as ET


def main():
    tree = ET.parse('package/manifest.mpd')

    ET.register_namespace('', 'urn:mpeg:dash:schema:mpd:2011')
    ET.register_namespace('xsi', 'http://www.w3.org/2001/XMLSchema-instance')
    ns = {'m': 'urn:mpeg:dash:schema:mpd:2011'}

    mpd = tree.getroot()

    inbandEventStream = ET.Element('InbandEventStream') 
    inbandEventStream.set('schemeIdUri', 'https://aomedia.org/emsg/ID3')
    inbandEventStream.set('value', '1')

    for adaptationSet in mpd.findall("./m:Period/m:AdaptationSet[@contentType='video']", ns):
        adaptationSet.insert(0, inbandEventStream)

    tree.write('package/manifest.mpd', 'UTF-8', True)

if __name__ == '__main__':
    main()

