//
//  DataSource.swift
//  ProjectM
//
//  Created by Niklas Børner on 02/04/2023.
//



import Foundation
import CoreData


class DataSource: NSObject, ObservableObject {
    
    static let shared = DataSource(type: .normal)
    static let preview = DataSource(type: .preview)
    static let testing = DataSource(type: .testing)
    
    @Published var tasks: Dictionary<UUID, Task> = [:]
    @Published var subTasks: Dictionary<UUID, SubTask> = [:]
    
    var tasksArray: [Task] {
        Array(tasks.values)
    }
    
    var subTasksArray: [SubTask] {
        Array(subTasks.values)
    }
    
    fileprivate var managedObjectContext: NSManagedObjectContext
    private let tasksFRC: NSFetchedResultsController<TaskMO>
    private let subTasksFRC: NSFetchedResultsController<SubTaskMO>
    
    private init(type: DataSourceType) {
        switch type {
        case .normal:
            let persistentController = PersistenceController()
            self.managedObjectContext = persistentController.viewContext
        case .preview:
            let persistentController = PersistenceController(inMemory: true)
            self.managedObjectContext = persistentController.viewContext
            for i in 0..<10 {
                let newTask = TaskMO(context: managedObjectContext)
                newTask.id = UUID()
                newTask.name = "Task \(i)"
                newTask.note = "This is Task \(i)"
                newTask.color = ProjectColors(rawValue: Int16.random(in: 0..<4)) ?? .standard
                newTask.deadline = Date()
                newTask.estimation = Double.random(in: 0...120)
                newTask.state = TaskState(rawValue: Int16.random(in: 0...1)) ?? .ToDo
                newTask.timestamp = Date()
                
                for j in 0..<6 {
                    let newSubTask = SubTaskMO(context: managedObjectContext)
                    newSubTask.id = UUID()
                    newSubTask.name = "SubTask \(j)"
                    newTask.note = "This is SubTask \(j) belonging to Task \(i)"
                    newSubTask.state = TaskState(rawValue: Int16.random(in: 0...1)) ?? .ToDo
                    newSubTask.task = newTask
                    newSubTask.timestamp = Date()
                }
            }
            try? self.managedObjectContext.save()
        case .testing:
            let persistentController = PersistenceController(inMemory: true)
            self.managedObjectContext = persistentController.viewContext
        }
        
        let taskFR: NSFetchRequest<TaskMO> = TaskMO.fetchRequest()
        taskFR.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        tasksFRC = NSFetchedResultsController(fetchRequest: taskFR,
                                              managedObjectContext: managedObjectContext,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)
        
        let subTaskFR: NSFetchRequest<SubTaskMO> = SubTaskMO.fetchRequest()
        subTaskFR.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        subTasksFRC = NSFetchedResultsController(fetchRequest: subTaskFR,
                                                 managedObjectContext: managedObjectContext,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
        
        super.init()
        
        // Initial fetch to populate todos array
        tasksFRC.delegate = self
        try? tasksFRC.performFetch()
        if let newTasks = tasksFRC.fetchedObjects {
            self.tasks = Dictionary(uniqueKeysWithValues: newTasks.map({ ($0.id!, Task(taskMO: $0)) }))
        }
        
        subTasksFRC.delegate = self
        try? subTasksFRC.performFetch()
        if let newSubTasks = subTasksFRC.fetchedObjects {
            self.subTasks = Dictionary(uniqueKeysWithValues: newSubTasks.map({ ($0.id!, SubTask(subTaskMO: $0)) }))
        }
    }
    
    func saveData() {
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
            } catch let error as NSError {
                NSLog("Unresolved error saving context: \(error), \(error.userInfo)")
            }
        }
    }
}

extension DataSource: NSFetchedResultsControllerDelegate {
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if let newTasks = controller.fetchedObjects as? [TaskMO] {
            self.tasks = Dictionary(uniqueKeysWithValues: newTasks.map({ ($0.id!, Task(taskMO: $0)) }))
        } else if let newSubTasks = controller.fetchedObjects as? [SubTaskMO] {
            self.subTasks = Dictionary(uniqueKeysWithValues: newSubTasks.map({ ($0.id!, SubTask(subTaskMO: $0)) }))
        }
    }
    
    private func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let request = objectType.fetchRequest()
        request.predicate = predicate
        request.fetchLimit = 1
        do {
            let result = try managedObjectContext.fetch(request) as? [T]
            return .success(result?.first)
        } catch {
            return .failure(error)
        }
    }
    
    func fetchTasks(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) {
        if let predicate = predicate {
            tasksFRC.fetchRequest.predicate = predicate
        }
        if let sortDescriptors = sortDescriptors {
            tasksFRC.fetchRequest.sortDescriptors = sortDescriptors
        }
        try? tasksFRC.performFetch()
        if let newTasks = tasksFRC.fetchedObjects {
            self.tasks = Dictionary(uniqueKeysWithValues: newTasks.map({ ($0.id!, Task(taskMO: $0)) }))
        }
    }
    
    func resetFetch() {
        tasksFRC.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        tasksFRC.fetchRequest.predicate = nil
        try? tasksFRC.performFetch()
        if let newTasks = tasksFRC.fetchedObjects {
            self.tasks = Dictionary(uniqueKeysWithValues: newTasks.map({ ($0.id!, Task(taskMO: $0)) }))
        }
    }

}

//MARK: - Todo Methods
extension Task {
    
    fileprivate init(taskMO: TaskMO) {
        self.id = taskMO.id ?? UUID()
        self.title = taskMO.name!
        self.description = taskMO.note ?? ""
        self.state = taskMO.state
        self.deadline = taskMO.deadline
        self.estimation = taskMO.estimation
        self.color = taskMO.color
        self.timestamp = taskMO.timestamp!
        if let subTasksMOs = taskMO.subtasks as? Set<SubTaskMO> {
            let subTaskMOsArray = subTasksMOs.sorted(by: {$0.timestamp! < $1.timestamp!})
            self.subtasks = subTaskMOsArray.compactMap({$0.id})
        } else {
            self.subtasks = []
        }
    }
}

extension DataSource {
    
    func updateAndSave(task: Task) {
        let predicate = NSPredicate(format: "id = %@", task.id as CVarArg)
        let result = fetchFirst(TaskMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let taskMo = managedObject {
                update(taskMO: taskMo, from: task)
            } else {
                createTaskMO(from: task)
            }
        case .failure(_):
            print("Couldn't fetch TaskMO to save")
        }
        
        saveData()
    }
    
    func delete(task: Task) {
        let predicate = NSPredicate(format: "id = %@", task.id as CVarArg)
        let result = fetchFirst(TaskMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let taskMo = managedObject {
                deleteSubtasks(task: task)
                managedObjectContext.delete(taskMo)
            }
        case .failure(_):
            print("Couldn't fetch TaskMO to save")
        }
        saveData()
    }
    
    func deleteSubtasks(task: Task) {
        for id in task.subtasks {
            if let foundSubTask = getSubTask(with: id) {
                delete(subTask: foundSubTask)
            }
        }
    }
    
    func getTask(with id: UUID) -> Task? {
        return tasks[id]
    }
    
    private func createTaskMO(from task: Task) {
        let taskMO = TaskMO(context: managedObjectContext)
        taskMO.id = task.id
        update(taskMO: taskMO, from: task)
    }
    
    private func update(taskMO: TaskMO, from task: Task) {
        taskMO.name = task.title
        taskMO.note = task.description
        taskMO.state = task.state
        taskMO.deadline = task.deadline
        taskMO.estimation = task.estimation ?? 0.0
        taskMO.color = task.color
        taskMO.timestamp = task.timestamp
        
        let subtaskMOs = task.subtasks.compactMap({getSubTaskMO(from:getSubTask(with: $0))})
        taskMO.subtasks = NSSet(array: subtaskMOs)
    }
    
    private func getTaskMO(from task: Task?) -> TaskMO? {
        guard let task = task else { return nil }
        let predicate = NSPredicate(format: "id = %@", task.id as CVarArg)
        let result = fetchFirst(TaskMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let taskMO = managedObject {
                return taskMO
            } else {
                return nil
            }
        case .failure(_):
            return nil
        }
        
    }
    
}

//MARK: - Project Methods
extension SubTask {
    
    fileprivate init(subTaskMO: SubTaskMO) {
        self.id = subTaskMO.id ?? UUID()
        self.title = subTaskMO.name!
        self.description = subTaskMO.note
        self.state = subTaskMO.state
        self.timestamp = subTaskMO.timestamp!
        self.taskId = (subTaskMO.task?.id)!
    }
}

extension DataSource {
    func updateAndSave(subTask: SubTask) {
        let predicate = NSPredicate(format: "id = %@", subTask.id as CVarArg)
        let result = fetchFirst(SubTaskMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let subTaskMO = managedObject {
                update(subTaskMO: subTaskMO, from: subTask)
            } else {
                createSubTaskMO(from: subTask)
            }
        case .failure(_):
            print("Couldn't fetch SubTaskMO to save")
        }
        
        saveData()
    }
    
    func delete(subTask: SubTask) {
        let predicate = NSPredicate(format: "id = %@", subTask.id as CVarArg)
        let result = fetchFirst(SubTaskMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let subTaskMO = managedObject {
                managedObjectContext.delete(subTaskMO)
            }
        case .failure(_):
            print("Couldn't fetch TodoMO to save")
        }
        saveData()
    }
    
    func getSubTask(with id: UUID) -> SubTask? {
        return subTasks[id]
    }
    
    private func createSubTaskMO(from subTask: SubTask) {
        let subTaskMO = SubTaskMO(context: managedObjectContext)
        subTaskMO.id = subTask.id
        update(subTaskMO: subTaskMO, from: subTask)
    }
    
    private func update(subTaskMO: SubTaskMO, from subTask: SubTask) {
        subTaskMO.name = subTask.title
        subTaskMO.note = subTask.description
        subTaskMO.state = subTask.state
        subTaskMO.timestamp = subTask.timestamp
        if let task = getTask(with: subTask.taskId) {
            subTaskMO.task = getTaskMO(from: task)
        } else {
            subTaskMO.task = nil
        }
    }
    
    private func getSubTaskMO(from subTask: SubTask? ) -> SubTaskMO? {
        guard let subTask = subTask else { return nil }
        let predicate = NSPredicate(format: "id = %@", subTask.id as CVarArg)
        let result = fetchFirst(SubTaskMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let subTaskMO = managedObject {
                return subTaskMO
            } else {
                return nil
            }
        case .failure(_):
            return nil
        }
    }
}

