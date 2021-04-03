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
    //var name: String { get set }
}

class ChatRequestInteractor: ChatRequestBusinessLogic, ChatRequestDataStore {
    
    var presenter: ChatRequestPresentationLogic?
    var service: ChatRequestService?
    
    //var name: String = ""
    
    func makeRequest(request: ChatRequest.Model.Request.RequestType) {
        if service == nil {
            service = ChatRequestService()
        }
    }
    
}
