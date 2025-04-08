//
//  MapView.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import SwiftUI
import InteractiveMap
import CoreData
import Combine

///  Экран карты
struct MapView: View {
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            InteractiveMap(svgName: "world") { pathData in
                let countryCode = pathData.id
                InteractiveShape(pathData)
                    .fill(viewModel.visitedCountries.contains(countryCode) ? Color.orangeDark.opacity(0.7) : Color.gray.opacity(0.3))
                    .stroke(Color.orangeDark.opacity(0.5), lineWidth: 0.3)
            }
            .scaleEffect(viewModel.scale)
            .offset(viewModel.offset)
            .frame(width: geometry.size.width * 0.9, height: geometry.size.height * 0.5)
            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.6)
            .gesture(
                SimultaneousGesture(
                    MagnificationGesture()
                        .onChanged { value in
                            viewModel.updateScale(value.magnitude)
                        }
                        .onEnded { _ in
                            viewModel.updateLastScale()
                        },
                    DragGesture()
                        .onChanged { value in
                            viewModel.updateOffset(value.translation)
                        }
                        .onEnded { _ in
                            viewModel.updateLastOffset()
                        }
                )
            )
        }
        .background(Color.black)
        .edgesIgnoringSafeArea(.all)
    }
}
