//
//  StringExtension.swift
//  TextfieldValidator
//
//  Created by Chainarong Chaiyaphat on 6/19/18.
//  Copyright © 2018 Chainarong Chaiyaphat. All rights reserved.
//

import Foundation

extension String {

    func isCharacter()-> Bool{
        return regex(pattern: ".*[^A-Za-z].*")
    }
    
    func isNumeric() -> Bool {
        return regex(pattern: ".*[^0-9].*")
    }
    
    func hasSpecialCharacter() -> Bool {
        return !regex(pattern: ".*[^A-Za-z0-9].*")
    }
    
    func isEmailFormat() -> Bool{
        return !regex(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}")
    }
    
    private func regex(pattern: String) -> Bool{
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        let range = NSRange(location: 0, length: self.count)
        if regex.matches(in: self, options: [], range: range).count > 0 {
            return false
        }
        return true
    }
    
    
}


