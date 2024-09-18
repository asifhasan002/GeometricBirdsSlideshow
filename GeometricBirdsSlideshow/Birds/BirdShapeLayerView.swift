//
//  BirdShapeLayerView.swift
//  GeometricBirdsSlideshow

import SwiftUI

struct BirdShapeLayerView: UIViewRepresentable {
    var shapeLayer: CAShapeLayer
    
    func makeUIView(context: Context) -> UIView {
        print("shapeLayer")
        let view = UIView()
        let transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        shapeLayer.setAffineTransform(transform)
        view.layer.addSublayer(shapeLayer)
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {
        // Update logic if needed
    }
}





