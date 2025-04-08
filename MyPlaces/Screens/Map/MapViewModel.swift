import Foundation
import SwiftUI
import Combine

@MainActor
final class MapViewModel: ObservableObject {
    @Published var scale: CGFloat = 1.0
    @Published var offset: CGSize = .zero
    @Published var lastScale: CGFloat = 1.0
    @Published var lastOffset: CGSize = .zero
    @Published var visitedCountries: Set<String> = []
    
    private let coreDataManager: CoreDataManager
    
    init(coreDataManager: CoreDataManager = .shared) {
        self.coreDataManager = coreDataManager
        loadVisitedCountries()
    }
    
    func updateScale(_ value: CGFloat) {
        let newScale = lastScale * value
        scale = min(max(newScale, 0.5), 5.0)
    }
    
    func updateLastScale() {
        lastScale = scale
    }
    
    func updateOffset(_ translation: CGSize) {
        offset = CGSize(
            width: lastOffset.width + translation.width,
            height: lastOffset.height + translation.height
        )
    }
    
    func updateLastOffset() {
        lastOffset = offset
    }
    
    private func loadVisitedCountries() {
        let countries = coreDataManager.fetchCountries()
        visitedCountries = Set(countries.filter { $0.been }.compactMap { $0.cca2 })
    }
} 
