//
//  PeopleInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseAuth
import FirebaseFirestore

protocol PeopleBusinessLogic {
    func makeRequest(request: People.Model.Request.RequestType)
}

protocol PeopleDataStore {
    var currentUser: MUser! { get set }
    var selectedUser: MUser? { get set }
    var message: String? { get set }
}

class PeopleInteractor: PeopleBusinessLogic, PeopleDataStore {
    
    var presenter: PeoplePresentationLogic?
    var service: PeopleService?
    
    var currentUser: MUser!
    var selectedUser: MUser?
    var message: String?
    
    private var usersListener: ListenerRegistration?
    
    deinit {
        usersListener?.remove()
    }
    
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
            
        case .setTitle:
            presenter?.presentData(response: .presentTitle(currentUser!.username))
            
        case .setUsersListener(let users):
            usersListener = ListenerService.shared.usersObserve(users: users, completion: { (result) in
                switch result {
                case .success(let users):
                    self.presenter?.presentData(response: .presentUsers(users))
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription, type: .other))
                }
            })
            
        case .userSelected(let user):
            selectedUser = user
            presenter?.presentData(response: .presentProfile)
            
        case .createWaitingChat:
            FirestoreService.shared.createWaitingChat(message: message!, receiver: selectedUser!) { (result) in
                switch result {
                case .success(_):
                    self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Ваше сообщение для \(self.selectedUser!.username) было отправлено", type: .other))
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription, type: .other))
                }
            }
            
        }
    }
    
}
