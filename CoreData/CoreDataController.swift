//
//  CoreDataController.swift
//  Pearson
//
//  Created by Arnaud Aubry on 15/07/15.
//  Copyright (c) 2015 Arnaud Aubry. All rights reserved.
//

import UIKit
import CoreData

struct CoreDataController {
    static func managedObjectContext() -> NSManagedObjectContext {
        let delegate = UIApplication.sharedApplication().delegate as! AppDelegate
        return delegate.managedObjectContext
    }

    static func createObjectForEntity(name name: String) -> NSManagedObject {
        return NSEntityDescription.insertNewObjectForEntityForName(name, inManagedObjectContext: CoreDataController.managedObjectContext()) 
    }

    static func save() {
        dispatch_async(dispatch_get_main_queue(), { () -> Void in
            do {
                try CoreDataController.managedObjectContext().save()
            }
            catch {
                assert(false, "CoreData save did fail, reason: \((error as NSError).localizedDescription)")
            }
        })
    }
}
