//
//  String.swift
//  GoogleKeep
//
//  Created by admin on 06/04/21.
//

import Foundation
extension String{
    
    func validateEmailId() -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return applyPredicateOnRegex(regexStr: emailRegEx)
    }
    
    func validatePassword() -> Bool {
        let passRegEx = "^(?=.*[A-Za-z])(?=.*\\d)[A-Za-z\\d]{\(8),}$"
        return applyPredicateOnRegex(regexStr: passRegEx)
    }
    
    
    func applyPredicateOnRegex(regexStr: String) -> Bool{
        let trimmedString = self.trimmingCharacters(in: .whitespaces)
        let validateOtherString = NSPredicate(format: "SELF MATCHES %@", regexStr)
        let isValidateOtherString = validateOtherString.evaluate(with: trimmedString)
        return isValidateOtherString
    }
}
