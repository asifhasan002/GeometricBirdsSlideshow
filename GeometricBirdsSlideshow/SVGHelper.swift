////
////  SVGHelper.swift.swift
////  GeometricBirdsSlideshow
//
import SwiftUI
import PocketSVG

class SVGHelper {
    
    func loadSVG(birdName: String) -> ([SVGBezierPath], [Color]) {
        let svgPathURL = Bundle.main.url(forResource: birdName, withExtension: "svg")
        let paths = SVGBezierPath.pathsFromSVG(at: svgPathURL!)
        let colors: [Color] = SVGHelper.extractColorsFromSVG(named: birdName).compactMap { Color(hex: $0) }
        return (paths, colors)
    }
    
    static func extractColorsFromSVG(named fileName: String) -> [String] {
        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "svg") else { return [] }
        guard let xmlData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return [] }

        var colors: [String] = []
        class SVGParserDelegate: NSObject, XMLParserDelegate {
            var colors: [String]
            init(colors: [String]) { self.colors = colors }
            func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes: [String: String]) {
                if let fillColor = attributes["fill"] { colors.append(fillColor) }
                if let strokeColor = attributes["stroke"] { colors.append(strokeColor) }
            }
        }
        let parserDelegate = SVGParserDelegate(colors: colors)
        let parser = XMLParser(data: xmlData)
        parser.delegate = parserDelegate
        parser.parse()
        return parserDelegate.colors
    }
}


