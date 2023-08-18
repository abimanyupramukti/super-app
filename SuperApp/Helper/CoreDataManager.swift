//
//  CoreDataManager.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 16/08/23.
//

import Foundation
import CoreData

final class CoreDataManager {
    static let shared = CoreDataManager()
    
    private let container = NSPersistentContainer(name: "ToDoList")
    private let context: NSManagedObjectContext
    
    private init() {
        context = container.viewContext
        
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("error loading persistent store: \(error.localizedDescription)")
            }
        }
    }
    
    func create<T: NSManagedObject>(type: T.Type) -> T {
        return T(context: context)
    }
    
    func fetch<T: NSManagedObject>(type: T.Type) -> [T] {
        do {
            return try context.fetch(type.fetchRequest()) as? [T] ?? []
        } catch (let error) {
            fatalError("error fetching data: \(error.localizedDescription)")
        }
    }
    
    func save() {
        guard context.hasChanges else { return }
        do {
            try context.save()
        } catch (let error) {
            context.rollback()
            let error = error as NSError
            print("error saving data: \(error.userInfo)")
        }
    }
    
    func getObject<T: NSManagedObject>(id: NSManagedObjectID) ->  T {
        context.object(with: id) as! T
    }
    
    func delete<T: NSManagedObject>(object: T) {
        context.delete(object)
        save()
    }
    
    func insert<T: NSManagedObject>(object: T) {
        context.insert(object)
        save()
    }
}
