//
//  ProfilePresenter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfilePresentationLogic {
    func presentData(response: Profile.Model.Response.ResponseType)
}

class ProfilePresenter: ProfilePresentationLogic {
    
    weak var viewController: ProfileDisplayLogic?
    
    func presentData(response: Profile.Model.Response.ResponseType) {
        switch response {
        case let .presentUserInfo(username, description, avatarStringUrl):
            viewController?.displayData(viewModel: .displayUserInfo(username: username, description: description, avatarUrl: URL(string: avatarStringUrl)))
            
        case .presentParent:
            viewController?.displayData(viewModel: .displayParent)
        }
    }
    
}
