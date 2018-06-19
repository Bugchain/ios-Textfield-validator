//
//  ViewController.swift
//  TextfieldValidator
//
//  Created by Chainarong Chaiyaphat on 6/19/18.
//  Copyright © 2018 Chainarong Chaiyaphat. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var data: [IndexPath: String] = [:]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.setTableProperties()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func setTableProperties(){
        self.tableView.estimatedRowHeight = 200
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    func validateSuccessCallback(indexPath: IndexPath)-> ((_ text: String, _ desc: String)-> Void){
        
        return { (text, resultDesc) in
            self.data[indexPath] = text
        }
    }
    
    func validateFailedCallback(indexPath: IndexPath)-> ((_ text: String, _ desc: String)-> Void){
        return { (text, resultDesc) in
            self.data[indexPath] = text
        }
    }
}


extension ViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldValidatorTableViewCell", for: indexPath) as! TextFieldValidatorTableViewCell
        cell.validateSuccessCallback = validateSuccessCallback(indexPath: indexPath)
        cell.validateFailedCallback = validateFailedCallback(indexPath: indexPath)
        cell.textField.text = data[indexPath]
        cell.editFlag = data[indexPath] != nil
        
        switch indexPath.row {
        case 0:
            cell.validatorCellType = .UsernameCell
        case 1:
            cell.validatorCellType = .PaswordCell
        case 2:
            cell.validatorCellType = .EmailCell
        case 3:
            cell.validatorCellType = .Firstname
        default:
            cell.validatorCellType = .None
        }
        return cell
    }
    
}
