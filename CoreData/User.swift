//
//  User.swift
//  CoreData
//
//  Created by Arnaud Aubry on 18/11/2015.
//  Copyright © 2015 Yolo. All rights reserved.
//

import UIKit
import Foundation
import CoreData


class User: NSManagedObject {

    static func create() -> User {
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let newUser = NSEntityDescription.insertNewObjectForEntityForName("User", inManagedObjectContext: appDelegate.managedObjectContext) as! User

        return newUser
    }

    static func fetchResultsController(predicate: NSPredicate?, sectionNameKeyPath: String?, sortDescriptors: [NSSortDescriptor]?) -> NSFetchedResultsController {
        let fetchRequest = NSFetchRequest(entityName: "User")
        
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.predicate = predicate
        
        let fetchResult = NSFetchedResultsController(fetchRequest: fetchRequest,
            managedObjectContext: CoreDataController.managedObjectContext(),
            sectionNameKeyPath: sectionNameKeyPath, cacheName: nil)
        return fetchResult
    }
    
}
