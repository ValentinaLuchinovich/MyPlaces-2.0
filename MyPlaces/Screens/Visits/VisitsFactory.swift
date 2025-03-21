//
//  VisitsFactory.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 21.03.2025.
//

import UIKit

struct VisitsFactory {
    func build(coordinator: VisitsCoordinator) -> UIViewController {
        let visitsService = VisitsService()
        let visitsRepository = VisitsRepository(visitsService: visitsService)
        let viewModel = VisitsViewModel(coordinator: coordinator, visitsRepository: visitsRepository)
        return VisitsViewController(viewModel)
    }
}
