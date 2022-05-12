//
//  Client+CoreDataProperties.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 12.05.2022.
//
//

import CoreData


extension DomainClient {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<DomainClient> {
        return NSFetchRequest<DomainClient>(entityName: "DomainClient")
    }

    @NSManaged public var address: String
    @NSManaged public var name: String?

}

extension DomainClient : Identifiable {

}
