//
//  ProfileInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ProfileBusinessLogic {
    func makeRequest(request: Profile.Model.Request.RequestType)
}

protocol ProfileDataStore {
    //var name: String { get set }
}

class ProfileInteractor: ProfileBusinessLogic, ProfileDataStore {
    
    var presenter: ProfilePresentationLogic?
    var service: ProfileService?
    
    //var name: String = ""
    
    func makeRequest(request: Profile.Model.Request.RequestType) {
        if service == nil {
            service = ProfileService()
        }
    }
    
}
