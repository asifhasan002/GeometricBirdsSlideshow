////
////  BirdShapeLayer+Morph.swift
////  GeometricBirdsSlideshow
////
//
import SwiftUI
import PocketSVG
import Combine

class BirdShapeLayerManager: ObservableObject {
    var birdShapeLayers: [CAShapeLayer] = []
    var duration = 1.0
    
    func setupBirdShapeLayer(from birdData: [([SVGBezierPath], [Color])]) {
        guard let firstBird = birdData.first else { return }
        for (index, path) in firstBird.0.enumerated() {
            let shapeLayer = CAShapeLayer()
            shapeLayer.path = path.cgPath
            shapeLayer.fillColor = UIColor(firstBird.1[index % firstBird.1.count]).cgColor
            birdShapeLayers.append(shapeLayer)
        }
    }
    
    func startAnimation(from startData: ([SVGBezierPath], [Color]), to nextData: ([SVGBezierPath], [Color]), birdShapeLayers: [CAShapeLayer], duration: Double, onCompletion: @escaping () -> Void) {
        morph(from: startData, to: nextData, birdShapeLayers: birdShapeLayers, duration: duration, completion: onCompletion)
    }
    
    private func morph(from startData: ([SVGBezierPath], [Color]), to nextData: ([SVGBezierPath], [Color]), birdShapeLayers: [CAShapeLayer], duration: Double, completion: @escaping () -> Void) {
        let startPaths = startData.0
        let endPaths = nextData.0
        let startColors = startData.1
        let endColors = nextData.1
        
        for i in 0..<startPaths.count {
            let shapeLayer = birdShapeLayers[i]
            
            let morphAnimation = CABasicAnimation(keyPath: "path")
            morphAnimation.fromValue = startPaths[i].cgPath
            morphAnimation.toValue = endPaths[i].cgPath
            morphAnimation.duration = duration
            morphAnimation.fillMode = .forwards
            morphAnimation.isRemovedOnCompletion = false
            
            let colorAnimation = CABasicAnimation(keyPath: "fillColor")
            colorAnimation.fromValue = UIColor(startColors[i]).cgColor
            colorAnimation.toValue = UIColor(endColors[i]).cgColor
            colorAnimation.duration = duration
            
            shapeLayer.fillColor = endColors[i % endColors.count].cgColor
            shapeLayer.add(morphAnimation, forKey: "pathAnimation")
            shapeLayer.add(colorAnimation, forKey: "colorAnimation")
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration + 3.0) {
            completion()
        }
    }
}
