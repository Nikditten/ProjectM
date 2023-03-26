//
//  Persistence.swift
//  ProjectM
//
//  Created by Niklas Børner on 12/03/2023.
//

import CoreData
import Combine

struct PersistenceController {
    static let shared = PersistenceController()
    
    let container: NSPersistentCloudKitContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }

    init(inMemory: Bool = false) {
        container = NSPersistentCloudKitContainer(name: "ProjectM")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        container.viewContext.automaticallyMergesChangesFromParent = true
    }

    func save() throws {
        let context = container.viewContext
        if context.hasChanges {
            try context.save()
        }
    }
    
    func add(_ object: NSManagedObject) throws {
        viewContext.insert(object)
        try save()
    }

    func fetchAllTasks() -> [Task]{
        
        var tasks: [Task] = []
        
        // Make a request for WorkItem objects
        let request: NSFetchRequest<Task> = Task.fetchRequest()
        
        // Sort the object by the date attribute in a non ascending order
        request.sortDescriptors = [NSSortDescriptor(keyPath: \Task.deadline, ascending: false)]
        
        // Fetch the result of the request
        do {
            tasks = try viewContext.fetch(request)
        } catch let error as NSError {
            // In case of an error - print the error description
            print(error.localizedDescription)
        }
        
        return tasks
    }

}
