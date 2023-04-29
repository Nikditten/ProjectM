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
    
    @Published var projects: Dictionary<UUID, Project> = [:]
    @Published var tasks: Dictionary<UUID, Task> = [:]
    
    var projectsArray: [Project] {
        Array(projects.values)
    }
    
    var tasksArray: [Task] {
        Array(tasks.values)
    }
    
    fileprivate var managedObjectContext: NSManagedObjectContext
    private let projectsFRC: NSFetchedResultsController<ProjectMO>
    private let tasksFRC: NSFetchedResultsController<TaskMO>
    
    private init(type: DataSourceType) {
        switch type {
        case .normal:
            let persistentController = PersistenceController()
            self.managedObjectContext = persistentController.viewContext
        case .preview:
            let persistentController = PersistenceController(inMemory: true)
            self.managedObjectContext = persistentController.viewContext
            for i in 0..<10 {
                let newProject = ProjectMO(context: managedObjectContext)
                newProject.id = UUID()
                newProject.name = "Project \(i)"
                newProject.note = "This is Project \(i)"
                newProject.color = ProjectColors(rawValue: Int16.random(in: 0..<4)) ?? .standard
                newProject.deadline = Date()
                newProject.estimation = Double.random(in: 0...120)
                newProject.state = TaskState(rawValue: Int16.random(in: 0...1)) ?? .ToDo
                newProject.timestamp = Date()
                
                for j in 0..<6 {
                    let newSubProject = TaskMO(context: managedObjectContext)
                    newSubProject.id = UUID()
                    newSubProject.name = "Task \(j)"
                    newProject.note = "This is Task \(j) belonging to Project \(i)"
                    newSubProject.state = TaskState(rawValue: Int16.random(in: 0...1)) ?? .ToDo
                    newSubProject.project = newProject
                    newSubProject.timestamp = Date()
                }
            }
            try? self.managedObjectContext.save()
        case .testing:
            let persistentController = PersistenceController(inMemory: true)
            self.managedObjectContext = persistentController.viewContext
        }
        
        let projectFR: NSFetchRequest<ProjectMO> = ProjectMO.fetchRequest()
        projectFR.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        projectsFRC = NSFetchedResultsController(fetchRequest: projectFR,
                                              managedObjectContext: managedObjectContext,
                                              sectionNameKeyPath: nil,
                                              cacheName: nil)
        
        let taskFR: NSFetchRequest<TaskMO> = TaskMO.fetchRequest()
        taskFR.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        tasksFRC = NSFetchedResultsController(fetchRequest: taskFR,
                                                 managedObjectContext: managedObjectContext,
                                                 sectionNameKeyPath: nil,
                                                 cacheName: nil)
        
        super.init()
        
        // Initial fetch to populate todos array
        projectsFRC.delegate = self
        try? projectsFRC.performFetch()
        if let newProjects = projectsFRC.fetchedObjects {
            self.projects = Dictionary(uniqueKeysWithValues: newProjects.map({ ($0.id!, Project(projectMO: $0)) }))
        }
        
        tasksFRC.delegate = self
        try? tasksFRC.performFetch()
        if let newSubProjects = tasksFRC.fetchedObjects {
            self.tasks = Dictionary(uniqueKeysWithValues: newSubProjects.map({ ($0.id!, Task(taskMO: $0)) }))
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
        if let newProjects = controller.fetchedObjects as? [ProjectMO] {
            self.projects = Dictionary(uniqueKeysWithValues: newProjects.map({ ($0.id!, Project(projectMO: $0)) }))
        } else if let newSubProjects = controller.fetchedObjects as? [TaskMO] {
            self.tasks = Dictionary(uniqueKeysWithValues: newSubProjects.map({ ($0.id!, Task(taskMO: $0)) }))
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
    
    func fetchProjects(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor]? = nil) {
        if let predicate = predicate {
            projectsFRC.fetchRequest.predicate = predicate
        }
        if let sortDescriptors = sortDescriptors {
            projectsFRC.fetchRequest.sortDescriptors = sortDescriptors
        }
        try? projectsFRC.performFetch()
        if let newProjects = projectsFRC.fetchedObjects {
            self.projects = Dictionary(uniqueKeysWithValues: newProjects.map({ ($0.id!, Project(projectMO: $0)) }))
        }
    }
    
    func resetFetch() {
        projectsFRC.fetchRequest.sortDescriptors = [NSSortDescriptor(key: "timestamp", ascending: true)]
        projectsFRC.fetchRequest.predicate = nil
        try? projectsFRC.performFetch()
        if let newProjects = projectsFRC.fetchedObjects {
            self.projects = Dictionary(uniqueKeysWithValues: newProjects.map({ ($0.id!, Project(projectMO: $0)) }))
        }
    }

}

//MARK: - Todo Methods
extension Project {
    
    fileprivate init(projectMO: ProjectMO) {
        self.id = projectMO.id ?? UUID()
        self.title = projectMO.name!
        self.description = projectMO.note ?? ""
        self.state = projectMO.state
        self.deadline = projectMO.deadline
        self.estimation = projectMO.estimation
        self.color = projectMO.color
        self.timestamp = projectMO.timestamp!
        if let tasksMOs = projectMO.tasks as? Set<TaskMO> {
            let taskMOsArray = tasksMOs.sorted(by: {$0.timestamp! < $1.timestamp!})
            self.tasks = taskMOsArray.compactMap({$0.id})
        } else {
            self.tasks = []
        }
    }
}

extension DataSource {
    
    func updateAndSave(project: Project) {
        let predicate = NSPredicate(format: "id = %@", project.id as CVarArg)
        let result = fetchFirst(ProjectMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let projectMo = managedObject {
                update(projectMO: projectMo, from: project)
            } else {
                createProjectMO(from: project)
            }
        case .failure(_):
            print("Couldn't fetch ProjectMO to save")
        }
        
        saveData()
    }
    
    func delete(project: Project) {
        let predicate = NSPredicate(format: "id = %@", project.id as CVarArg)
        let result = fetchFirst(ProjectMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let projectMo = managedObject {
                deleteTasks(project: project)
                managedObjectContext.delete(projectMo)
            }
        case .failure(_):
            print("Couldn't fetch ProjectMO to save")
        }
        saveData()
    }
    
    func deleteTasks(project: Project) {
        for id in project.tasks {
            if let foundSubProject = getTask(with: id) {
                delete(task: foundSubProject)
            }
        }
    }
    
    func getProject(with id: UUID) -> Project? {
        return projects[id]
    }
    
    private func createProjectMO(from project: Project) {
        let projectMO = ProjectMO(context: managedObjectContext)
        projectMO.id = project.id
        update(projectMO: projectMO, from: project)
    }
    
    private func update(projectMO: ProjectMO, from project: Project) {
        projectMO.name = project.title
        projectMO.note = project.description
        projectMO.state = project.state
        projectMO.deadline = project.deadline
        projectMO.estimation = project.estimation ?? 0.0
        projectMO.color = project.color
        projectMO.timestamp = project.timestamp
        
        let subtaskMOs = project.tasks.compactMap({getTaskMO(from:getTask(with: $0))})
        projectMO.tasks = NSSet(array: subtaskMOs)
    }
    
    private func getProjectMO(from project: Project?) -> ProjectMO? {
        guard let project = project else { return nil }
        let predicate = NSPredicate(format: "id = %@", project.id as CVarArg)
        let result = fetchFirst(ProjectMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let projectMO = managedObject {
                return projectMO
            } else {
                return nil
            }
        case .failure(_):
            return nil
        }
        
    }
    
}

//MARK: - Project Methods
extension Task {
    
    fileprivate init(taskMO: TaskMO) {
        self.id = taskMO.id ?? UUID()
        self.title = taskMO.name!
        self.description = taskMO.note
        self.state = taskMO.state
        self.timestamp = taskMO.timestamp!
        self.projectId = (taskMO.project?.id)!
    }
}

extension DataSource {
    func updateAndSave(task: Task) {
        let predicate = NSPredicate(format: "id = %@", task.id as CVarArg)
        let result = fetchFirst(TaskMO.self, predicate: predicate)
        switch result {
        case .success(let managedObject):
            if let taskMO = managedObject {
                update(taskMO: taskMO, from: task)
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
            if let taskMO = managedObject {
                managedObjectContext.delete(taskMO)
            }
        case .failure(_):
            print("Couldn't fetch TodoMO to save")
        }
        saveData()
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
        taskMO.timestamp = task.timestamp
        if let project = getProject(with: task.projectId) {
            taskMO.project = getProjectMO(from: project)
        } else {
            taskMO.project = nil
        }
    }
    
    private func getTaskMO(from task: Task? ) -> TaskMO? {
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

