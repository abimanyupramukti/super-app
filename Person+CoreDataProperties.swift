//
//  Person+CoreDataProperties.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 18/08/23.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged var dob: Date?
    @NSManaged var name: String?
    @NSManaged var jobs: NSSet?

}

// MARK: Generated accessors for jobs
extension Person {

    @objc(addJobsObject:)
    @NSManaged public func addToJobs(_ value: Job)

    @objc(removeJobsObject:)
    @NSManaged public func removeFromJobs(_ value: Job)

    @objc(addJobs:)
    @NSManaged public func addToJobs(_ values: NSSet)

    @objc(removeJobs:)
    @NSManaged public func removeFromJobs(_ values: NSSet)

}

extension Person : Identifiable {

}
