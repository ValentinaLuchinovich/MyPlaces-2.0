//
//  CoreDataManager.swift
//  MyPlaces
//
//  Created by Валентина Лучинович on 27.03.2025.
//

import UIKit
import CoreData

// -MARK: Create/Read/Update/Delete
public final class CoreDataManager: NSObject  {
    public static let shared = CoreDataManager()
    
    // Приватный инит позволяет быть уверенным в том, что экземпляр класса будет точно один
    private override init() {}
    
    private var appDelegate: AppDelegate {
        UIApplication.shared.delegate as! AppDelegate
    }
    
    private var context: NSManagedObjectContext {
        appDelegate.persistentContainer.viewContext
    }
    
    public func createCountry(flag: String, name: String, cca2: String, been: Bool) {
        let country = NSEntityDescription.insertNewObject(forEntityName: "Country", into: context) as? Country
        country?.flag = flag
        country?.name = name
        country?.cca2 = cca2
        country?.been = been
        
        appDelegate.saveContext()
    }
    
    public func fetchCountries() -> [Country] {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        do {
            return try context.fetch(fetchRequest) as! [Country]
        } catch {
            print("Не удалось получить список стран: \(error)")
            return []
        }
    }
    
    public func updateCountry(with name: String, been: Bool ) {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        do {
            guard let countries = try? context.fetch(fetchRequest) as? [Country],
                  let country = countries.first(where: { $0.name == name}) else { return }
            country.been = been
        }
        
        appDelegate.saveContext()
    }
    
    public func deleteAllCountries() {
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Country")
        do {
            let countries = try? context.fetch(fetchRequest) as? [Country]
            countries?.forEach { context.delete($0) }
        }
        
        appDelegate.saveContext()
    }
}
