//
//  BusinessNumber+CoreDataProperties.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 12.05.2022.
//
//

import CoreData

extension DomainBusinessNumber {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DomainBusinessNumber> {
        return NSFetchRequest<DomainBusinessNumber>(entityName: "DomainBusinessNumber")
    }
    
    @NSManaged public var number: String
    @NSManaged public var label: String
}

extension DomainBusinessNumber : Identifiable {

}
