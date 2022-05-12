//
//  Call+CoreDataProperties.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 12.05.2022.
//
//

import CoreData

extension DomainCall {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DomainCall> {
        return NSFetchRequest<DomainCall>(entityName: "DomainCall")
    }

    @NSManaged public var id: String
    @NSManaged public var created: Date
    @NSManaged public var duration: String
    @NSManaged public var state: String
    @NSManaged public var type: String
    @NSManaged public var origin: String
    @NSManaged public var favorite: Bool
    @NSManaged public var client: DomainClient
    @NSManaged public var businessNumber: DomainBusinessNumber

}

extension DomainCall : Identifiable {

}
