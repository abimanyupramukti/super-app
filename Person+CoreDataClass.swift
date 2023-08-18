//
//  Person+CoreDataClass.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 18/08/23.
//
//

import Foundation
import CoreData

@objc(Person)
public class Person: NSManagedObject {
    public var nameValue: String {
        set {
            name = newValue
        }
        get {
            name ?? ""
        }
    }
    
    public var dobValue: Date {
        set {
            dob = newValue
        }
        get {
            dob ?? .now
        }
    }
}
