//
//  DomainService.swift
//  NordCloudTestAssignment
//
//  Created by Vladimir Banushkin on 06.05.2022.
//

import CoreData

final class DomainService {
    
    enum Constants {
        static let modelName: String = "NordCloudTestAssignment"
    }
    
        // MARK: - Public Properties
    
        var container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: Constants.modelName)
            container.loadPersistentStores { _, error in
                if let error = error as NSError? {
                    fatalError("Unresolved error \(error), \(error.userInfo)")
                }
            }
            return container
        }()
        
        // MARK: - Private Properties
        
        private lazy var context = container.viewContext
        
        
        // MARK: - Public Methods
        
        func save() {
            container.newBackgroundContext()
            guard context.hasChanges else { return }
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
        
        func deleteObject<T: NSManagedObject> (object: T) {
            context.delete(object)
            save()
        }
        
        func fetchData<T: NSManagedObject> (
            for entity: T.Type,
            withPredicate predicate: NSCompoundPredicate? = nil,
            withSortDescriptor sortDescriptors: [NSSortDescriptor]? = nil
        ) -> [T]? {
            
            var fetchedResult: [T]?
            let request = T.fetchRequest()
            request.predicate = predicate
            request.sortDescriptors = sortDescriptors
            do {
                fetchedResult = try context.fetch(request) as? [T]
            } catch {
                debugPrint("Error occurred: \(error.localizedDescription)")
            }
            return fetchedResult
        }
}
