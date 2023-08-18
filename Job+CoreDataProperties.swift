//
//  Job+CoreDataProperties.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 18/08/23.
//
//

import Foundation
import CoreData


extension Job {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Job> {
        return NSFetchRequest<Job>(entityName: "Job")
    }

    @NSManaged var date: Date?
    @NSManaged var isDone: Bool
    @NSManaged var name: String?
    @NSManaged var note: String?
    @NSManaged var priority: Int64
    @NSManaged var owner: Person?

}

extension Job : Identifiable {

}
