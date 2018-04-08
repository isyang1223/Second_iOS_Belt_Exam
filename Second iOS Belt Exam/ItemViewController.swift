//
//  ItemViewController.swift
//  Second iOS Belt Exam
//
//  Created by Ian Yang on 3/27/18.
//  Copyright © 2018 Ian Yang. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController {
    var delegate: ItemViewControllerDelegate?
    var firstName: String?
    var lastName: String?
    var number: String?
    var indexPath: IndexPath?
    
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        delegate?.doneButtonPressed(by: self)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameLabel.text = firstName! + " " + lastName!
        numberLabel.text = number!

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    



}
protocol ItemViewControllerDelegate: class {
    func doneButtonPressed(by controller: ItemViewController)
}
