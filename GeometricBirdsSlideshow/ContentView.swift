//
//  ContentView.swift
//  GeometricBirdsSlideshow

import SwiftUI
import PocketSVG
import Combine

struct ContentView: View {
    @StateObject private var viewModel = ContentViewModel()
    
    var body: some View {
        VStack {
            GeometryReader { geometry in
                ZStack {
                    ForEach(viewModel.birdShapeLayers.indices, id: \.self) { index in
                        BirdShapeLayerView(shapeLayer: viewModel.birdShapeLayers[index])
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        viewModel.startSequentialAnimation()
                    }
                }
            }
            
            ZStack {
                Text(viewModel.texts[viewModel.currentDotIndex])
                    .font(.system(size: 36, weight: .bold))
                    .transition(.opacity)
                    .position(x: 600)
                
                Dots(currentDotIndex: viewModel.currentDotIndex,
                     dotColors: DotColors.colors)
                .padding(.top, 40)
                
                .position(x: 600)
                .padding(.top, 40)
            }.frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    ContentView()
}




//struct ContentView: View {
//    @State private var birdData: [([SVGBezierPath], [Color])] = []
//    @State private var currentIndex: Int = 0
//    @State private var nextIndex: Int = 1
//    @State private var birdShapeLayers: [CAShapeLayer] = []
//    @State private var duration = 1.0
//    @State private var currentDotIndex: Int = 0
//    
//    let texts = ["Great tit", "Bullfinch", "Dunnock", "Dove", "Mockingbird"]
//    let numberOfDots = 5
//    let grayDotSize: CGFloat = 10.0
//    let coloredDotSize: CGFloat = 15.0
//    let dotSpacing: CGFloat = 15.0
//    let dotColors = [
//        Color(red: 230/255.0, green: 197/255.0, blue: 131/255.0),
//        Color(red: 183/255.0, green: 73/255.0, blue: 53/255.0),
//        Color(red: 133/255.0, green: 87/255.0, blue: 49/255.0),
//        Color(red: 102/255.0, green: 143/255.0, blue: 141/255.0),
//        Color(red: 97/255.0, green: 104/255.0, blue: 114/255.0)
//    ]
//    
//    var body: some View {
//        VStack {
//            GeometryReader { geometry in
//                ZStack {
//                    ForEach(0..<birdShapeLayers.count, id: \.self) { index in
//                        BirdShapeLayerView(shapeLayer: birdShapeLayers[index])
//                    }
//                }
//                .onAppear {
//                    loadBirdData()
//                    setupBirdShapeLayer()
//                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                        startSequentialAnimation()
//                    }
//                }
//            }
//            
//            ZStack {
//                
//                Text(texts[currentDotIndex])
//                    .font(.system(size: 36, weight: .bold))
//                    .transition(.opacity)
//                    .position(x: 600)
//                
//                HStack(spacing: dotSpacing) {
//                    ForEach(0..<numberOfDots, id: \.self) { index in
//                        if index == currentDotIndex {
//                            Rectangle()
//                                .fill(dotColors[index])
//                                .frame(width: coloredDotSize, height: coloredDotSize)
//                                .transition(.scale)
//                        } else {
//                            Circle()
//                                .fill(Color.gray)
//                                .frame(width: grayDotSize, height: grayDotSize)
//                        }
//                    }
//                }
//                .position(x: 600)
//                .padding(.top, 40)
//            }.frame(maxHeight: .infinity)
//        }
//    }
//    
//    func loadBirdData() {
//        birdData.append(loadSVG(birdName: "bird1"))
//        birdData.append(loadSVG(birdName: "bird2"))
//        birdData.append(loadSVG(birdName: "bird3"))
//        birdData.append(loadSVG(birdName: "bird4"))
//        birdData.append(loadSVG(birdName: "bird5"))
//    }
//    
//    func setupBirdShapeLayer() {
//        if let firstBird = birdData.first {
//            for (index, path) in firstBird.0.enumerated() {
//                let shapeLayer = CAShapeLayer()
//                shapeLayer.path = path.cgPath
//                shapeLayer.fillColor = UIColor(firstBird.1[index % firstBird.1.count]).cgColor
//                birdShapeLayers.append(shapeLayer)
//            }
//        }
//    }
//    
//    func loadSVG(birdName: String) -> ([SVGBezierPath], [Color]) {
//        let svgPathURL = Bundle.main.url(forResource: birdName, withExtension: "svg")
//        let paths = SVGBezierPath.pathsFromSVG(at: svgPathURL!)
//        let colors: [Color] = extractColorsFromSVG(named: birdName).compactMap { Color(hex: $0) }
//        return (paths, colors)
//    }
//    
//    func startSequentialAnimation() {
//        func animateNext() {
//            let nextData = birdData[nextIndex]
//            morph(from: birdData[currentIndex], to: nextData) {
//                currentIndex = nextIndex
//                nextIndex = (nextIndex + 1) % birdData.count
//                animateNext()
//            }
//            
//            Timer.scheduledTimer(withTimeInterval: 0.0, repeats: false) { _ in
//                withAnimation(.easeInOut(duration: duration)) {
//                    currentDotIndex = (currentDotIndex + 1) % texts.count
//                }
//            }
//        }
//        animateNext()
//    }
//    
//    func morph(from startData: ([SVGBezierPath], [Color]), to nextData: ([SVGBezierPath], [Color]), completion: @escaping () -> Void) {
//        let startPaths = startData.0
//        let endPaths = nextData.0
//        let startColors = startData.1
//        let endColors = nextData.1
//        
//        for i in 0..<startPaths.count {
//            let shapeLayer = birdShapeLayers[i]
//            
//            let morphAnimation = CABasicAnimation(keyPath: "path")
//            morphAnimation.fromValue = startPaths[i].cgPath
//            morphAnimation.toValue = endPaths[i].cgPath
//            morphAnimation.duration = duration
//            morphAnimation.fillMode = .forwards
//            morphAnimation.isRemovedOnCompletion = false
//            
//            let colorAnimation = CABasicAnimation(keyPath: "fillColor")
//            colorAnimation.fromValue = UIColor(startColors[i]).cgColor
//            colorAnimation.toValue = UIColor(endColors[i]).cgColor
//            colorAnimation.duration = duration
//            
//            shapeLayer.fillColor = endColors[i % endColors.count].cgColor
//            shapeLayer.add(morphAnimation, forKey: "pathAnimation")
//            shapeLayer.add(colorAnimation, forKey: "colorAnimation")
//        }
//        
//        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 3.0) {
//            completion()
//        }
//    }
//    
//    func extractColorsFromSVG(named fileName: String) -> [String] {
//        guard let filePath = Bundle.main.path(forResource: fileName, ofType: "svg") else { return [] }
//        guard let xmlData = try? Data(contentsOf: URL(fileURLWithPath: filePath)) else { return [] }
//        
//        var colors: [String] = []
//        class SVGParserDelegate: NSObject, XMLParserDelegate {
//            var colors: [String]
//            init(colors: [String]) { self.colors = colors }
//            func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes: [String: String]) {
//                if let fillColor = attributes["fill"] { colors.append(fillColor) }
//                if let strokeColor = attributes["stroke"] { colors.append(strokeColor) }
//            }
//        }
//        let parserDelegate = SVGParserDelegate(colors: colors)
//        let parser = XMLParser(data: xmlData)
//        parser.delegate = parserDelegate
//        parser.parse()
//        return parserDelegate.colors
//    }
//}
//
//struct BirdShapeLayerView: UIViewRepresentable {
//    var shapeLayer: CAShapeLayer
//    
//    func makeUIView(context: Context) -> UIView {
//        let view = UIView()
//        
//        let transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
//        shapeLayer.setAffineTransform(transform)
//        
//        view.layer.addSublayer(shapeLayer)
//        return view
//    }
//    
//    func updateUIView(_ uiView: UIView, context: Context) {
//        // Update logic if needed
//    }
//}
//
//extension Color {
//    init?(hex: String) {
//        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
//        if hexSanitized.hasPrefix("#") { hexSanitized.remove(at: hexSanitized.startIndex) }
//        guard hexSanitized.count == 6 else { return nil }
//        var rgb: UInt64 = 0
//        Scanner(string: hexSanitized).scanHexInt64(&rgb)
//        let red = Double((rgb >> 16) & 0xFF) / 255.0
//        let green = Double((rgb >> 8) & 0xFF) / 255.0
//        let blue = Double(rgb & 0xFF) / 255.0
//        self.init(red: red, green: green, blue: blue)
//    }
//}
