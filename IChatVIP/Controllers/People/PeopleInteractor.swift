//
//  PeopleInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth

protocol PeopleBusinessLogic {
    func makeRequest(request: People.Model.Request.RequestType)
}

protocol PeopleDataStore {
    var currentUser: MUser? { get set }
}

class PeopleInteractor: PeopleBusinessLogic, PeopleDataStore {
    
    var presenter: PeoplePresentationLogic?
    var service: PeopleService?
    
    var currentUser: MUser?
    
    func makeRequest(request: People.Model.Request.RequestType) {
        if service == nil {
            service = PeopleService()
        }
        
        switch request {
        case .signOut:
            do {
                try Auth.auth().signOut()
                self.presenter?.presentData(response: .presentAuth)
            } catch {
                print("Error signing out: \(error.localizedDescription)")
            }
        }
    }
    
}
