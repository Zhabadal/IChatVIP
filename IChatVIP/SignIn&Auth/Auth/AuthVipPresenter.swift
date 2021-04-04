//
//  AuthVipPresenter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AuthVipPresentationLogic {
    func presentData(response: AuthVip.Model.Response.ResponseType)
}

class AuthVipPresenter: AuthVipPresentationLogic {
    weak var viewController: AuthVipDisplayLogic?
    
    func presentData(response: AuthVip.Model.Response.ResponseType) {
        switch response {
        case let .presentAlert(title, message, type):
            viewController?.displayData(viewModel: .displayAlert(title: title, message: message, type: type))
        }
    }
    
}
