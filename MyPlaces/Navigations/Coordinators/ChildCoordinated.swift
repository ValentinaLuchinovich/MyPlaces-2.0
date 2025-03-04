//
//  ChildCoordinated.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 03.03.2025.
//

protocol ChildCoordinated: Coordinator {
    associatedtype Screen
    func start(with screen: Screen)
}
