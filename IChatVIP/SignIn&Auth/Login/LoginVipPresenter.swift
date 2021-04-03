//
//  LoginVipPresenter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol LoginVipPresentationLogic {
    func presentData(response: LoginVip.Model.Response.ResponseType)
}

class LoginVipPresenter: LoginVipPresentationLogic {
    weak var viewController: LoginVipDisplayLogic?
    
    func presentData(response: LoginVip.Model.Response.ResponseType) {
        switch response {
        case let .presentAlert(title, message):
            viewController?.displayData(viewModel: .displayAlert(title: title, message: message))
        }
    }
    
}
