//
//  ValidationService.swift
//  XCTestDemo
//
//  Created by jaekyung you on 2020/12/20.
//

import Foundation


struct ValidationService {
    
    func validateUsername(_ username: String?) throws -> String {
        guard let username = username else {
            throw ValidationError.invalidValue
        }
        guard username.count > 3 else { throw ValidationError.usernameTooShort }
        guard username.count < 20 else { throw ValidationError.usernameTooLong }
        return username
    }
    
    func validatePassworld(_ password: String?) throws -> String {
        guard let password = password else {
            throw ValidationError.invalidValue
        }
        guard password.count >= 8 else { throw ValidationError.passwordTooShort }
        guard password.count < 20 else { throw ValidationError.passwordTooLong }
        return password
    }
}

enum ValidationError: LocalizedError{
    case invalidValue
    case usernameTooShort
    case usernameTooLong
    case passwordTooShort
    case passwordTooLong
    
    var errorDescription: String? {
        switch self {
        case .invalidValue:
             return "You have entered an invalid value"
        case .usernameTooShort:
            return "Username is too short"
        case .usernameTooLong:
            return "Username is too long"
        case .passwordTooShort:
            return "Password is too short"
        case .passwordTooLong:
            return "Passworld is too long"
        }
    }
}

enum LoginError: LocalizedError {
    case invalidCredentials
    
    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "This is invalid credentials"
        }
    }
}
