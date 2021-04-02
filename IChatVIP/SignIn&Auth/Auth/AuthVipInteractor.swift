//
//  AuthVipInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol AuthVipBusinessLogic {
    func makeRequest(request: AuthVip.Model.Request.RequestType)
}

class AuthVipInteractor: AuthVipBusinessLogic {
    
    var presenter: AuthVipPresentationLogic?
    var service: AuthVipService?
    
    func makeRequest(request: AuthVip.Model.Request.RequestType) {
        if service == nil {
            service = AuthVipService()
        }
    }
    
}
