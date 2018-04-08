//
//  AddItemViewController.swift
//  Second iOS Belt Exam
//
//  Created by Ian Yang on 3/27/18.
//  Copyright © 2018 Ian Yang. All rights reserved.
//

import UIKit

class AddItemViewController: UIViewController {
    
    var delegate: AddItemViewControllerDelegate?
    var indexPath: IndexPath?
    var firstName: String?
    var lastName: String?
    var number: String?

    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {
        let firstName = firstNameTextField.text!
        let lastName = lastNameTextField.text!
        let number = numberTextField.text!
        
        delegate?.itemSaved(by: self, with1: firstName, with2: lastName, with3: number, at: indexPath)
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        delegate?.cancelButtonPressed(by: self)
        print("cancel 1")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firstNameTextField.text = firstName
        lastNameTextField.text = lastName
        numberTextField.text = number
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

protocol AddItemViewControllerDelegate: class {
    func cancelButtonPressed(by controller: AddItemViewController)
    func itemSaved(by controller: AddItemViewController, with1 firstName: String, with2 lastName: String, with3 number: String, at indexPath: IndexPath?)
    
}
