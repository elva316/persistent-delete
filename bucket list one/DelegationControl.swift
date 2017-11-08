//
//  delegationFile.swift
//  bucket list one
//
//  Created by elva wang on 11/7/17.
//  Copyright © 2017 elva wang. All rights reserved.
//

import UIKit

protocol DelegationController: class {
    func cancelPressedFunc(by controller: AddItemViewController)
    func textSaveFunc(by controlelr: AddItemViewController, with text: String, at indexPath: NSIndexPath?)
}
