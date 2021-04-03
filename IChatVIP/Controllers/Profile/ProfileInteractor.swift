//
//  ProfileInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
    func makeRequest(request: Profile.Model.Request.RequestType)
}

protocol ProfileDataStore {
    var user: MUser! { get set }
    var message: String? { get set }
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    
    var presenter: ProfilePresentationLogic?
    var service: ProfileService?
    
    var user: MUser!
    var message: String?
    
    func makeRequest(request: Profile.Model.Request.RequestType) {
        if service == nil {
            service = ProfileService()
        }
        
        switch request {
        case .setUserInfo:
            presenter?.presentData(response: .presentUserInfo(username: user.username, description: user.description, avatarStringUrl: user.avatarStringURL))
            
        case .sendMessage(let text):
            guard let message = text, message != "" else { return }
            self.message = message
            presenter?.presentData(response: .presentParent)
        }
    }
    
}
