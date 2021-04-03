//
//  ChatRequestPresenter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ChatRequestPresentationLogic {
    func presentData(response: ChatRequest.Model.Response.ResponseType)
}

class ChatRequestPresenter: ChatRequestPresentationLogic {
    
    weak var viewController: ChatRequestDisplayLogic?
    
    func presentData(response: ChatRequest.Model.Response.ResponseType) {
        switch response {
        case .presentChatInfo(let friendUsername, let friendAvatarStringURL):
            viewController?.displayData(viewModel: .displayChatInfo(friendUsername: friendUsername, friendAvatarURL: URL(string: friendAvatarStringURL)))
        }
    }
    
}
