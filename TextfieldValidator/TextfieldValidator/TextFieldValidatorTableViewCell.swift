//
//  TextFieldValidatorTableViewCell.swift
//  TextfieldValidator
//
//  Created by Chainarong Chaiyaphat on 6/19/18.
//  Copyright © 2018 Chainarong Chaiyaphat. All rights reserved.
//

import UIKit

class TextFieldValidatorTableViewCell: UITableViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var messageLabel: UILabel!

    var validatorCellType = TextFieldValidatorTableViewCell.None
    var editFlag = false
    
    var validateSuccessCallback: ((_ text: String, _ result: String)-> Void) = {_, _ in}
    var validateFailedCallback: ((_ text: String, _ result: String)-> Void) = {_, _ in}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.setInterface()
    }
    
    func setInterface(){
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 3
        titleLabel.text = validatorCellType.title
        messageLabel.text = " "
    }
    
    func shouldVaidateTextField(){
        if editFlag{
            validate(self.textField)
        }
    }
    
    @IBAction func textFieldDidEndEditing(_ sender: Any) {
        validate(sender as! UITextField)
    }
    
    @IBAction func textFieldDidTextChange(_ sender: Any) {
        let tf = sender as! UITextField
        if tf.text?.count == 0 {
            validateSuccessHandler("")
            validateSuccessCallback("", "")
            return
        }
        validate(sender as! UITextField)
    }
    
    
    func validate(_ textField: UITextField){
        guard let text = textField.text else {return}
        let validateText = validatorCellType.validate(text)
        
        if validateText.result{
            validateSuccessHandler(validateText.desc)
            validateSuccessCallback(text, validateText.desc)
        }else{
            validateFailedHandler(validateText.desc)
            validateFailedCallback(text, validateText.desc)
        }
    }
    
    func validateSuccessHandler(_ desc: String){
        textField.layer.borderColor = UIColor.green.cgColor
        messageLabel.text = desc
    }
    
    func validateFailedHandler(_ desc: String){
        textField.layer.borderColor = UIColor.red.cgColor
        messageLabel.text = desc
    }

}



extension TextFieldValidatorTableViewCell {
    
    enum TextFieldValidatorTableViewCell {
        case UsernameCell
        case PaswordCell
        case EmailCell
        case Firstname
        case None
        
        func validate(_ text: String) -> (result: Bool, desc: String) {
            switch self {
            case .UsernameCell:
                if text.count < 8 {
                    return (false, "Username must longer than 8 characters")
                }
                else if text.count > 16 {
                    return(false, "Username must not longer than 16 characters")
                }
                else if text.isNumeric(){
                    return(false, "Username must contain at lease one character")
                }
                else if text.hasSpecialCharacter(){
                    return (false, "Username cannot contain any special character")
                }
                return (true,"")
            case .PaswordCell:
                if text.count < 6 {
                    return (false, "Password must longer than 6 characters")
                }
                else if text.count > 16 {
                    return (false, "Password must not longer than 16 characters")
                }
                else if text.hasSpecialCharacter() {
                    return (false, "Password cannot contain any special character")
                }
                return (true,"")
            case .EmailCell:
                if !text.isEmailFormat(){
                    return (false, "Invalid email format")
                }
                return (true,"")
            case .Firstname:
                if text.count < 2 {
                    return (false, "Firstname must longer than 2 cahracters")
                }
                else if !text.isCharacter(){
                    return ( false, "Only character is allowed")
                }
                return (true,"")
            case .None:
                return (false,"Something went wrong")
        }
    }
    
        var title: String {
            switch self {
            case .UsernameCell:
                return "Username"
            case .PaswordCell:
                return "Password"
            case .EmailCell:
                return "Email"
            case .Firstname:
                return "Firstname"
            case .None:
                return "Something went wrong"
            }
        }
    
    }
    
}
