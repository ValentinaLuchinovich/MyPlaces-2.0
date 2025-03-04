//
//  TabBarChildCoordinated.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

import UIKit

protocol TabBarChildCoordinated: Coordinator {
    func makeTab() -> UIViewController
}
