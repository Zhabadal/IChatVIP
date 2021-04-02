//
//  UserError.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//

import Foundation

enum UserError {
    case notFilled
    case photoNotExisted
    case cannotGetUserInfo
    case cannotUnwrapToMUser
}

extension UserError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .notFilled:
            return NSLocalizedString("Заполните все поля", comment: "")
        case .photoNotExisted:
            return NSLocalizedString("Пользователь не выбрал фото", comment: "")
        case .cannotGetUserInfo:
            return NSLocalizedString("Невозможно загрузить информацию о User из Firebase", comment: "")
        case .cannotUnwrapToMUser:
            return NSLocalizedString("Невозможно конвентировать MUser из User", comment: "")
        }
    }
}
