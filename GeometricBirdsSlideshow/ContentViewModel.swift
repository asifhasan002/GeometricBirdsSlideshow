//
//  ContentViewModel.swift
//  GeometricBirdsSlideshow
//
//  Created by rootnext05 on 18/9/24.
//

import SwiftUI

class ContentViewModel: ObservableObject {
    @Published var birdShapeLayers: [CAShapeLayer] = []
    @Published var currentDotIndex: Int = 0
    @Published var duration = 1.0
    
    private let birdDataManager: BirdDataManager
    private let shapeLayerManager: BirdShapeLayerManager
    
    private var currentIndex: Int = 0
    private var nextIndex: Int = 1
    
    let texts = ["Great tit", "Bullfinch", "Dunnock", "Dove", "Mockingbird"]
    
    init() {
        birdDataManager = BirdDataManager()
        shapeLayerManager = BirdShapeLayerManager()
        
        birdDataManager.loadBirdData()
        shapeLayerManager.setupBirdShapeLayer(from: birdDataManager.birdData)
        birdShapeLayers = shapeLayerManager.birdShapeLayers
    }
    
    func startSequentialAnimation() {
        shapeLayerManager.startAnimation(
            from: birdDataManager.birdData[currentIndex],
            to: birdDataManager.birdData[nextIndex],
            birdShapeLayers: shapeLayerManager.birdShapeLayers,
            duration: duration,
            onCompletion: {
                self.currentIndex = self.nextIndex
                self.nextIndex = (self.nextIndex + 1) % self.birdDataManager.birdData.count
                self.startSequentialAnimation()
            }
        )
        
        Timer.scheduledTimer(withTimeInterval: 0.0, repeats: false) { _ in
            withAnimation(.easeInOut(duration: self.duration)) {
                self.currentDotIndex = (self.currentDotIndex + 1) % self.texts.count
            }
        }
    }
}
