//
//  MapView.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import SwiftUI
import InteractiveMap

struct MapView: View {
    @State private var scale: CGFloat = 1.0
    @State private var offset: CGSize = .zero
    @State private var lastScale: CGFloat = 1.0
    @State private var lastOffset: CGSize = .zero
    
    var body: some View {
        GeometryReader { geometry in
            InteractiveMap(svgName: "world") { pathData in
                InteractiveShape(pathData)
                    .fill(.gray.opacity(0.3))
                    .stroke(Color.orangeDark .opacity(0.5), lineWidth: 0.3 )
            }
            .scaleEffect(scale)
            .offset(offset)
            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.5)
            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.6)
            .gesture(
                SimultaneousGesture(
                    MagnificationGesture()
                        .onChanged { value in
                            let newScale = lastScale * value.magnitude
                            scale = min(max(newScale, 0.5), 5.0)
                        }
                        .onEnded { value in
                            lastScale = scale
                        },
                    DragGesture()
                        .onChanged { value in
                            offset = CGSize(
                                width: lastOffset.width + value.translation.width,
                                height: lastOffset.height + value.translation.height
                            )
                        }
                        .onEnded { value in
                            lastOffset = offset
                        }
                )
            )
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}

