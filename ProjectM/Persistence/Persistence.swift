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

    func save() {
        let context = container.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                print(error)
            }
        }
    }
    
    func addProject(_ project: Project) {
        viewContext.insert(project)
        save()
    }
    
    func addTask(_ task: Task) {
        viewContext.insert(task)
        save()
    }
    
    func addSubTask(_ subtask: SubTask) {
        viewContext.insert(subtask)
        save()
    }

}
