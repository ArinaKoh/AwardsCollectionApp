//
//  MainView.swift
//  AwardsCollectionApp
//
//  Created by Alexey Efimov on 17.06.2021.
//

import SwiftUI

struct MainView: View {
    @State private var awardIsShowing = false
    
    var body: some View {
        VStack {
            Button(action: buttonAction) {
                HStack {
                    Text(awardIsShowing ? "Hide Award" : "Show Award")
                    Spacer()
                    Image(systemName: "chevron.up.square")
                        .scaleEffect(awardIsShowing ? 2 : 1)
                        .rotationEffect(.degrees(awardIsShowing ? 0 : 180))
                }
            }
            if awardIsShowing {
                Spacer()
                RingView()
                    .frame(width: 200, height: 200)
                    .transition(.scale)
            }
            Spacer()
        }
        .font(.headline)
        .padding()
    }
    
    private func buttonAction() {
        withAnimation {
            awardIsShowing.toggle()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

extension AnyTransition {
    static var leadingSlide: AnyTransition {
        let insertion = AnyTransition.move(edge: .leading)
            .combined(with: .scale)
        let removal = AnyTransition.scale
            .combined(with: .opacity)
        return .asymmetric(insertion: insertion, removal: removal)
    }
}
