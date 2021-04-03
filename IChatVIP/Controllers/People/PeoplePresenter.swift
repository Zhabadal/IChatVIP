//
//  PeoplePresenter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol PeoplePresentationLogic {
    func presentData(response: People.Model.Response.ResponseType)
}

class PeoplePresenter: PeoplePresentationLogic {
    
    weak var viewController: PeopleDisplayLogic?
    
    func presentData(response: People.Model.Response.ResponseType) {
        switch response {
        
        case .presentAuth:
            viewController?.displayData(viewModel: .displayAuth)
            
        case .presentTitle(let title):
            viewController?.displayData(viewModel: .displayTitle(title))
            
        case .presentUsers(let users):
            viewController?.displayData(viewModel: .displayUsers(users))
            
        case .presentAlert( let title, let message, let type):
            viewController?.displayData(viewModel: .displayAlert(title: title, message: message, type: type))
        }
    }
    
}
