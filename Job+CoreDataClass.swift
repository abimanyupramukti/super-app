//
//  Job+CoreDataClass.swift
//  SuperApp
//
//  Created by Abimanyu Pramukti on 18/08/23.
//
//

import Foundation
import CoreData

@objc(Job)
public class Job: NSManagedObject {
    
    public var dateValue: Date {
        set {
            date = newValue
        }
        get {
            date ?? .now
        }
    }
    
    public var isDoneValue: Bool {
        set {
            isDone = newValue
        }
        get {
            isDone
        }
    }
    
    public var nameValue: String {
        set {
            name = newValue
        }
        get {
            name ?? ""
        }
    }
    
    public var noteValue: String {
        set {
            note = newValue
        }
        get {
            note ?? ""
        }
    }
    
    public var priorityValue: Int64 {
        set {
            priority = newValue
        }
        get {
            priority
        }
    }
}
