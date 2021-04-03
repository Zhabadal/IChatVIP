//
//  AuthVipInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

protocol AuthVipBusinessLogic {
    func makeRequest(request: AuthVip.Model.Request.RequestType)
}

protocol AuthVipDataStore {
    var user: User? { get set }
    var muser: MUser? { get set }
}

class AuthVipInteractor: AuthVipBusinessLogic, AuthVipDataStore {
    
    var presenter: AuthVipPresentationLogic?
    var service: AuthVipService?
    
    var user: User?
    var muser: MUser?
    
    func makeRequest(request: AuthVip.Model.Request.RequestType) {
        if service == nil {
            service = AuthVipService()
        }
        
        switch request {
        case .googleLogin(let user, let error):
            AuthService.shared.googleLogin(user: user, error: error) { (result) in
                switch result {
                case .success(let user):
                    self.user = user
                    
                    FirestoreService.shared.getUserData(user: user) { (result) in
                        switch result {
                        case .success(let muser):
                            self.muser = muser
                            self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Вы авторизованы"))
                        case .failure(_):
                            self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Вы зарегистрированы"))
                        }
                    }
                    
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                }
            }
        }
    }
    
}
