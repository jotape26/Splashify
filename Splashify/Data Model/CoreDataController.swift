//
//  CoreDataController.swift
//  Splashify
//
//  Created by João Leite on 25/03/19.
//  Copyright © 2019 João Leite. All rights reserved.
//

import Foundation
import CoreData

class CoreDataController {
    let container: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init(modelName: String) {
        container = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil){
        container.loadPersistentStores { storeDescription, err in
            guard err == nil else {
                fatalError(err!.localizedDescription)
            }
            completion?()
        }
    }
}
