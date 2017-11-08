//
//  AddItemtableViewController.swift
//  bucket list one
//
//  Created by elva wang on 11/7/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    var delegate : DelegationController?
    var prePopulate : String?
    var indexPath: NSIndexPath?

    override func viewDidLoad() {
        super.viewDidLoad()
        testField.text = prePopulate
    }
    
    @IBOutlet weak var testField: UITextField!
    
    
    @IBAction func cancelPressed(_ sender: UIBarButtonItem) {
        print("Cancel working...")
        delegate?.cancelPressedFunc(by: self)


    }
    @IBAction func savePressed(_ sender: UIBarButtonItem) {
        if testField.text != nil {
            let text = testField.text!
            if text.count >= 1 {
                delegate?.textSaveFunc(by: self, with: text, at: indexPath)
            }
         }
     }
    
    
    

}






















//
