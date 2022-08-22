import xml.etree.ElementTree as ET


def main():
    tree = ET.parse('package/manifest.mpd')

    ET.register_namespace('', 'urn:mpeg:dash:schema:mpd:2011')
    ET.register_namespace('xsi', 'http://www.w3.org/2001/XMLSchema-instance')
    ns = {'m': 'urn:mpeg:dash:schema:mpd:2011'}

    mpd = tree.getroot()

    inbandEventStream = ET.Element('InbandEventStream') 
    inbandEventStream.set('schemeIdUri', 'urn:ygoto3:event:2022')
    inbandEventStream.set('value', '1')

    for adaptationSet in mpd.findall("./m:Period/m:AdaptationSet[@contentType='video']", ns):
        adaptationSet.insert(0, inbandEventStream)
        ET.dump(adaptationSet)

    tree.write('package/manifest1.mpd', 'UTF-8', True)

    return

if __name__ == '__main__':
    main()

