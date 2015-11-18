//
//  User+CoreDataProperties.swift
//  CoreDataTest
//
//  Created by Arnaud Aubry on 18/11/2015.
//  Copyright © 2015 Yolo. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension User {

    @NSManaged var identifier: String?
    @NSManaged var username: String?
    @NSManaged var email: String?
    @NSManaged var creationDate: NSDate?

}
