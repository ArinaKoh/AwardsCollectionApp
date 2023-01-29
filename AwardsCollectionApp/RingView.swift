//
//  RingView.swift
//  AwardsCollectionApp
//
//  Created by Arina on 29.01.2023.
//

import SwiftUI

struct RingView: View {
    var body: some View {
        RingSpinner()
    }
}

// MARK: - RingSpinner
struct RingSpinner: View {
    
    @State var pct: Double = 0.0

    var animation: Animation {
        .easeIn(duration: 0.7).repeatCount(4, autoreverses: true)
    }

    var body: some View {

        GeometryReader { geometry in
            
            let width = geometry.size.width
            let heigh = geometry.size.height
            
            ZStack {
                Path { path in

                    path.addArc(
                        center: CGPoint(
                        x: geometry.size.width / 2,
                        y: geometry.size.width / 2
                    ),
                                radius: geometry.size.width / 2,
                                startAngle: Angle(degrees: 0),
                                endAngle: Angle(degrees: 360),
                                clockwise: true
                    )
                }
                .stroke(
                    LinearGradient(
                        colors: [.red, .orange],
                        startPoint: .leading,
                        endPoint: .trailing),
                    lineWidth: 40)
               

                InnerRing(pct: self.pct).stroke(.yellow, lineWidth: 27)
            }
        }
        .aspectRatio(1, contentMode: .fit)
            .padding(20)
            .onAppear() {
                withAnimation(self.animation) {
                    self.pct = 1
                }
        }
    }
}

// MARK: - Inner Ring
struct InnerRing: Shape {
    
    var lag = 0.25
    var pct: Double
    
    var animatableData: Double {
        get { return pct }
        set { pct = newValue }
    }

    func path(in rect: CGRect) -> Path {

        let end = pct * 360
        var start: Double

        if pct > (1 - lag) {
            start = 360 * (2 * pct - 1)
        } else if pct > lag {
            start = 360 * (pct - lag)
        } else {
            start = 0
        }

        var path = Path()

        path.addArc(
            center: CGPoint(
                x: rect.size.width / 2,
                y: rect.size.width / 2
            ),
                 radius: rect.size.width / 2,
                 startAngle: Angle(degrees: start),
                 endAngle: Angle(degrees: end),
                 clockwise: false)

        return path
    }
}

// MARK: - Preview
struct RingView_Previews: PreviewProvider {
    static var previews: some View {
       RingView()
            .frame(width: 200, height: 200)
    }
}

