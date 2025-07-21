//
//  Validator.swift
//  NBCinema
//
//  Created by estelle on 7/20/25.
//

import Foundation

enum Validator {
    
    // 이메일 유효성 검사 (~~~@~~~.~~~)
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format:"SELF MATCHES %@", emailRegEx).evaluate(with: email)
    }
    
    // 비멀번호 유효성 검사 (영어 대소문자, 숫자, 특수문자 8자 이상, 특수문자 1개 이상)
    static func isValidPassword(_ password: String) -> Bool {
        let regex = #"^(?=.*[!@#$%^&*(),.?":{}|<>])[A-Za-z\d!@#$%^&*(),.?":{}|<>]{8,}$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: password)
    }
}
