//
//  ChatRequestInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ChatRequestBusinessLogic {
    func makeRequest(request: ChatRequest.Model.Request.RequestType)
}

protocol ChatRequestDataStore {
    var chat: MChat! { get set }
}

class ChatRequestInteractor: ChatRequestBusinessLogic, ChatRequestDataStore {
    
    var presenter: ChatRequestPresentationLogic?
    var service: ChatRequestService?
    
    var chat: MChat!
    
    func makeRequest(request: ChatRequest.Model.Request.RequestType) {
        if service == nil {
            service = ChatRequestService()
        }
        
        switch request {
        case .setChatInfo:
            presenter?.presentData(response: .presentChatInfo(friendUsername: chat.friendUsername, friendAvatarStringURL: chat.friendAvatarStringURL))
        }
    }
    
}
