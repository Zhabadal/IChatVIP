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
        }
    }
    
}
