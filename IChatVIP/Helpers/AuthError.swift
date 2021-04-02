//
//  AuthError.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//

import Foundation

enum AuthError {
    case notFilled
    case invalidEmail
    case passwordsNotMatched
    case serverError
    case unknownError
}

extension AuthError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .invalidEmail:
            return NSLocalizedString("Формат не является допустимым", comment: "")
        case .passwordsNotMatched:
            return NSLocalizedString("Пароли не совпадают", comment: "")
        case .serverError:
            return NSLocalizedString("Ошибка сервера", comment: "")
        case .unknownError:
            return NSLocalizedString("Неизвестная ошибка", comment: "")
        }
    }
}
