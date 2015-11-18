//
//  ViewController.swift
//  CoreData
//
//  Created by Arnaud Aubry on 18/11/2015.
//  Copyright © 2015 Yolo. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    lazy var fetchedResultsController: NSFetchedResultsController = {
//        let predicate = NSPredicate(format: "username = %@", "")
        let sortDescriptor = NSSortDescriptor(key: "creationDate", ascending: false)
        let fetchController = User.fetchResultsController(nil, sectionNameKeyPath: nil, sortDescriptors: [sortDescriptor])

        fetchController.delegate = self
        return fetchController
    }()
    
    lazy var dateFormatter: NSDateFormatter = {
        let dateFormatter = NSDateFormatter()

        dateFormatter.locale = NSLocale.currentLocale()
        dateFormatter.dateStyle = .ShortStyle
        dateFormatter.timeStyle = .MediumStyle
//        dateFormatter.doesRelativeDateFormatting = true
        return dateFormatter
    }()
    
    @IBAction func createNewUser(sender: AnyObject?) {
        let newUser = User.create()
        newUser.identifier = NSUUID().UUIDString
        newUser.username = "User Name"
        newUser.email = "user@gmail.com"
        newUser.creationDate = NSDate()
        CoreDataController.save()
    }
    
    @IBAction func removeAll(sender: AnyObject) {
        if let users = self.fetchedResultsController.fetchedObjects {
            users.forEach({ CoreDataController.managedObjectContext().deleteObject($0 as! NSManagedObject) })
            CoreDataController.save()
        }
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        do {
            try self.fetchedResultsController.performFetch()
        } catch {
            let alert = UIAlertController(title: "Error", message: "", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
            
            alert.addAction(alertAction)
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if let sections = self.fetchedResultsController.sections {
            return sections.count
        }
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = self.fetchedResultsController.sections {
            let currentSection = sections[section]
            return currentSection.numberOfObjects
        }
        return 0
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("userCell", forIndexPath: indexPath) 
        let user = self.fetchedResultsController.objectAtIndexPath(indexPath) as! User

        if let creationDate = user.creationDate {
            cell.textLabel?.text = self.dateFormatter.stringFromDate(creationDate)
        }
        return cell
    }
}

extension ViewController: NSFetchedResultsControllerDelegate {
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.tableView.reloadData()
    }
}
