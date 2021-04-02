//
//  Validators.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//

import Foundation

final class Validators {
    
    static func isFilled(email: String?, password: String?, confirmPassword: String?) -> Bool {
        guard let email = email, email != "",
              let password = password, password != "",
              let confirmPassword = confirmPassword, confirmPassword != ""
        else { return false }
        
        return true
    }
    
    static func isFilled(username: String?, description: String?, sex: String?) -> Bool {
        guard let username = username, username != "",
              let description = description, description != "",
              let sex = sex, sex != ""
        else { return false }
        
        return true
    }
    
    static func isSimpleEmail(_ email: String) -> Bool {
        let emailRegEx = "^.+@.+\\..{2,}$"
        return check(text: email, regEx: emailRegEx)
    }
    
    private static func check(text: String, regEx: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regEx)
        return predicate.evaluate(with: text)
    }
    
}
