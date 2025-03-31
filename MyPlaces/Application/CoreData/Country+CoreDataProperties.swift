//
//  Country+CoreDataProperties.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 27.03.2025.
//
//

import Foundation
import CoreData

@objc(Country)
public class Country: NSManagedObject { }

extension Country {
    @NSManaged public var flag: String
    @NSManaged public var name: String
    @NSManaged public var been: Bool

}

extension Country : Identifiable {

}
