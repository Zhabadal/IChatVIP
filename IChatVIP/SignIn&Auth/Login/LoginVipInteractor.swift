//
//  LoginVipInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol LoginVipBusinessLogic {
    func makeRequest(request: LoginVip.Model.Request.RequestType)
}

protocol LoginVipDataStore {
    var user: User? { get set }
    var muser: MUser? { get set }
}

class LoginVipInteractor: LoginVipBusinessLogic, LoginVipDataStore {
    
    var presenter: LoginVipPresentationLogic?
    var service: LoginVipService?
    
    var user: User?
    var muser: MUser?
    
    func makeRequest(request: LoginVip.Model.Request.RequestType) {
        if service == nil {
            service = LoginVipService()
        }
        
        switch request {
        case let .loginUser(email, password):
            AuthService.shared.login(email: email, password: password) { (result) in
                switch result {
                case .success(let user):
                    self.user = user
                    
                    FirestoreService.shared.getUserData(user: user) { (result) in
                        switch result {
                        case .success(let muser):
                            self.muser = muser
                            self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Вы авторизованы", type: .authorized))
                        case .failure(_):
                            self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Вы зарегистрированы", type: .registered))
                        }
                    }
                    
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription, type: .other))
                }
            }
            
        case .googleLogin(let user, let error):
            AuthService.shared.googleLogin(user: user, error: error) { (result) in
                switch result {
                case .success(let user):
                    self.user = user
                    
                    FirestoreService.shared.getUserData(user: user) { (result) in
                        switch result {
                        case .success(let muser):
                            self.muser = muser
                            self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Вы авторизованы", type: .authorized))
                        case .failure(_):
                            self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Вы зарегистрированы", type: .registered))
                        }
                    }
                    
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription, type: .other))
                }
            }
            
        }
    }
    
}
