////
////  Dots.swift
////  GeometricBirdsSlideshow
//
import SwiftUI

struct Dots: View {
    let currentDotIndex: Int
    let numberOfDots: Int = 5
    let grayDotSize: CGFloat = 10.0
    let coloredDotSize: CGFloat = 15.0
    let dotSpacing: CGFloat = 15.0
    let dotColors: [Color]

    var body: some View {
        HStack(spacing: dotSpacing) {
            ForEach(0..<numberOfDots, id: \.self) { index in
                if index == currentDotIndex {
                    Rectangle()
                        .fill(dotColors[index])
                        .frame(width: coloredDotSize, height: coloredDotSize)
                        .transition(.scale)
                } else {
                    Circle()
                        .fill(Color.gray)
                        .frame(width: grayDotSize, height: grayDotSize)
                }
            }
        }
    }
}

