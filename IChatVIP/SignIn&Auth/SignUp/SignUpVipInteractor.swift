//
//  SignUpVipInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol SignUpVipBusinessLogic {
    func makeRequest(request: SignUpVip.Model.Request.RequestType)
}

protocol SignUpVipDataStore {
    var user: User? { get set }
}

class SignUpVipInteractor: SignUpVipBusinessLogic, SignUpVipDataStore {
    
    var presenter: SignUpVipPresentationLogic?
    var service: SignUpVipService?
    
    var user: User?
    
    func makeRequest(request: SignUpVip.Model.Request.RequestType) {
        if service == nil {
            service = SignUpVipService()
        }
        
        switch request {
        case let .registerUser(email, password, confirmPassword):
            AuthService.shared.register(email: email, password: password, confirmPassword: confirmPassword) { (result) in
                switch result {
                case .success(let user):
                    self.user = user
                    self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Вы зарегистрированы"))
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                }
            }
        }
    }
    
}
