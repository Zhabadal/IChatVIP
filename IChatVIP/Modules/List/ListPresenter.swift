//
//  ListPresenter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ListPresentationLogic {
    func presentData(response: List.Model.Response.ResponseType)
}

class ListPresenter: ListPresentationLogic {
    
    weak var viewController: ListDisplayLogic?
    
    func presentData(response: List.Model.Response.ResponseType) {
        switch response {
        case .presentTitle(let title):
            viewController?.displayData(viewModel: .displayTitle(title))
        
        case .presentChatRequest:
            viewController?.displayData(viewModel: .displayChatRequest)
            
        case .presentChat:
            viewController?.displayData(viewModel: .displayChat)
            
        case .presentWaitingChats(let chats):
            viewController?.displayData(viewModel: .displayWaitingChats(chats))
            
        case .presentActiveChats(let chats):
            viewController?.displayData(viewModel: .displayActiveChats(chats))
            
        case .presentAlert(let title, let message):
            viewController?.displayData(viewModel: .displayAlert(title: title, message: message))
        }
    }
    
}
