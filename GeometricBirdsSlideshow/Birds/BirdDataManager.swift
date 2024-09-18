////
////  BirdsData.swift
////  GeometricBirdsSlideshow
//
//
import SwiftUI
import PocketSVG

class BirdDataManager {
    var birdData: [([SVGBezierPath], [Color])] = []
    
    func loadBirdData() {
        birdData = (1...5).map { SVGHelper().loadSVG(birdName: "bird\($0)") }
    }
}

