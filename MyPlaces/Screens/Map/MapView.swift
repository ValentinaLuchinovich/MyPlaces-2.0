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
    // MARK: Constants
    
    private enum Constants {
        static let mapWidth: CGFloat = 0.9
        static let mapHeight: CGFloat = 0.5
        static let mapVerticalPosition: CGFloat = 0.6
        static let strokeWidth: CGFloat = 0.3
        static let visitedOpacity: CGFloat = 0.7
        static let unvisitedOpacity: CGFloat = 0.3
        static let strokeOpacity: CGFloat = 0.5
    }
    
    @StateObject private var viewModel = MapViewModel()
    
    var body: some View {
        GeometryReader { geometry in
            InteractiveMap(svgName: "world") { pathData in
                let countryCode = pathData.id
                InteractiveShape(pathData)
                    .fill(viewModel.visitedCountries.contains(countryCode) ? Color.orangeDark.opacity(Constants.visitedOpacity) : Color.gray.opacity(Constants.unvisitedOpacity))
                    .stroke(Color.orangeDark.opacity(Constants.strokeOpacity), lineWidth: Constants.strokeWidth)
            }
            .scaleEffect(viewModel.scale)
            .offset(viewModel.offset)
            .frame(width: geometry.size.width * Constants.mapWidth, height: geometry.size.height * Constants.mapHeight)
            .position(x: geometry.size.width / 2, y: geometry.size.height * Constants.mapVerticalPosition)
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
