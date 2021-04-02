//
//  ListInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ListBusinessLogic {
    func makeRequest(request: List.Model.Request.RequestType)
}

protocol ListDataStore {
    var currentUser: MUser? { get set }
}

class ListInteractor: ListBusinessLogic, ListDataStore {
    
    var presenter: ListPresentationLogic?
    var service: ListService?
    
    var currentUser: MUser?
    
    func makeRequest(request: List.Model.Request.RequestType) {
        if service == nil {
            service = ListService()
        }
    }
    
}
