//
//  ContentView.swift
//  StickyEffect
//
//  Created by Prajwal U on 04/02/24.
//

import SwiftUI

struct ContentView: View {
    
    let centerWidth = UIScreen.main.bounds.width / 2
    let centerHeight = UIScreen.main.bounds.height / 2
    @State private var circleColor = Color.red
    @State var position = CGSize(width: 0, height: 0)
    
    var body: some View {
        Canvas{context , size in
            
            let firstCircle = context.resolveSymbol(id: 0)!
            let secondCircle = context.resolveSymbol(id: 1)!
            
            context.addFilter(.alphaThreshold(min: 0.3 , color: .primary))
            context.addFilter(.blur(radius: 15))
            
            context.drawLayer { context2 in
                context2.draw(firstCircle, at: .init(x:centerWidth , y: centerHeight))
                context.addFilter(.colorMultiply(.cyan))

                context2.draw(secondCircle, at: .init(x:centerWidth , y: centerHeight))
                
            }
            
        } symbols: {
            Circle()
                .frame(width: 60,height: 60,alignment: .center)
                .tag(0)
            Circle()
                .frame(width: 60,height: 60,alignment: .center)
                .offset(x: position.width , y: position.height)
                .tag(1)
        }
        
        .gesture(DragGesture().onChanged({ gesture in
            self.position = gesture.translation
        }).onEnded({ gesture in
            self.position = .zero
        })
        )
        .animation(.spring, value: self.position)
    }
}

#Preview {
    ContentView()
}
