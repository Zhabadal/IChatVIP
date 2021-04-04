//
//  ChatsPresenter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 04.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ChatsPresentationLogic {
    func presentData(response: Chats.Model.Response.ResponseType)
}

class ChatsPresenter: ChatsPresentationLogic {
    
    weak var viewController: ChatsDisplayLogic?
    
    func presentData(response: Chats.Model.Response.ResponseType) {
        switch response {
        case .presentUserInfo(let userId, let userName):
            viewController?.displayData(viewModel: .displayUserInfo(userId: userId, userName: userName))
            
        case .presentTitle(let title):
            viewController?.displayData(viewModel: .displayTitle(title))
            
        case .presentScrollToBottom:
            viewController?.displayData(viewModel: .displayScrollToBottom)
            
        case .presentAlert(let title, let message):
            viewController?.displayData(viewModel: .displayAlert(title: title, message: message))
            
        case .presentMessages(let messages, let isLatestMessage):
            viewController?.displayData(viewModel: .displayMessages(messages: messages, isLatestMessage: isLatestMessage))
        }
    }
    
}
