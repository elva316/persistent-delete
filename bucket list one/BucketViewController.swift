//
//  ViewController.swift
//  bucket list one
//
//  Created by elva wang on 11/7/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import UIKit
import CoreData   // +++++

class BucketViewController: UITableViewController, DelegationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllItems()
    }
    
//    var bucket = ["x","xx","xxx"]
    
    var bucket = [BucketListItem]()     ///++++++
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext  //  +++++++
    //  UIApplication.shared.delegate --  here we are looking inside the application   for the managedObjectContext, which is  --persistentContainer.viewContext, so we can add, delete, etc, and save to database
    //
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bucket.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "bucketCell", for: indexPath)
        cell.textLabel?.text = bucket[indexPath.row].text!
        return cell
    }
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        performSegue(withIdentifier: "editItem", sender: indexPath)
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        performSegue(withIdentifier: "editItem", sender: indexPath)
//    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let item = bucket[indexPath.row]
        managedObjectContext.delete(item)
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        bucket.remove(at: indexPath.row)
        tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addItem" {
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! AddItemViewController
            controller.delegate = self
        } else if segue.identifier == "editItem" {
            let nav = segue.destination as! UINavigationController
            let controller = nav.topViewController as! AddItemViewController
            controller.delegate = self

            let indexP = sender as! NSIndexPath
            let item = bucket[indexP.row]
            controller.prePopulate = item.text!
            controller.indexPath = indexP
        }
       
    }
    func fetchAllItems()  {    //  +++++ fetch data from database
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "BucketListItem")
        do {
            let result = try managedObjectContext.fetch(request)
            bucket = result as! [BucketListItem]     //   ++++++
        } catch {
            print("\(error)")
        }
    }
    
    
    
    
    
    func cancelPressedFunc(by controller: AddItemViewController) {
        print("I am the hidden controller, but I am reponding to the cancel button press on top view controller")
        
        dismiss(animated: true, completion: nil)
    }
    func textSaveFunc(by controlelr: AddItemViewController, with text: String, at indexPath: NSIndexPath?) {
        print("XXXXXXXXXXXX")
        if let ip = indexPath {
            let item = bucket[ip.row]
            item.text = text
        } else {
            let item = NSEntityDescription.insertNewObject(forEntityName: "BucketListItem", into: managedObjectContext) as! BucketListItem
            item.text = text
            bucket.append(item)
        }
        do {
            try managedObjectContext.save()
        } catch {
            print("\(error)")
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)

    }

}

