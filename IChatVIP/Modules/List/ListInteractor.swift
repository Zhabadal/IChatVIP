//
//  ListInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseFirestore

protocol ListBusinessLogic {
    func makeRequest(request: List.Model.Request.RequestType)
}

protocol ListDataStore {
    var currentUser: MUser! { get set }
    var chat: MChat? { get set }
}

class ListInteractor: ListBusinessLogic, ListDataStore {
    
    var presenter: ListPresentationLogic?
    var service: ListService?
    
    var currentUser: MUser!
    var chat: MChat?
    
    private var waitingChatsListener: ListenerRegistration?
    private var activeChatsListener: ListenerRegistration?
    
    func makeRequest(request: List.Model.Request.RequestType) {
        if service == nil {
            service = ListService()
        }
        
        switch request {
        case .setTitle:
            presenter?.presentData(response: .presentTitle(currentUser!.username))
            
        case .setChatsObservers(let waitingChats, let activeChats):
            waitingChatsListener = ListenerService.shared.waitingChatsObserve(chats: waitingChats, completion: { (result) in
                switch result {
                case .success(let chats):
                    // Может не сработать если это единственный чат.
                    // Можно сохранять кол-во чатов в памяти устройства, затем сверять с кол-вом из Firebase
                    if !waitingChats.isEmpty, waitingChats.count <= chats.count {
                        self.chat = chats.last
                        self.presenter?.presentData(response: .presentChatRequest)
                    }
                    
                    self.presenter?.presentData(response: .presentWaitingChats(chats))
                    
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                }
            })
            
            activeChatsListener = ListenerService.shared.activeChatsObserve(chats: activeChats, completion: { (result) in
                switch result {
                case .success(let chats):
                    self.presenter?.presentData(response: .presentActiveChats(chats))
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                }
            })
            
        case .chatSelected(let chat, let type):
            self.chat = chat
            
            switch type {
            case .waitingChat:
                presenter?.presentData(response: .presentChatRequest)
            case .activeChat:
                presenter?.presentData(response: .presentChat)
            }
            
        case .changeChatToActive:
            FirestoreService.shared.changeToActive(chat: chat!) { (result) in
                switch result {
                case .success():
                    self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Приятного общения с \(self.chat!.friendUsername)"))
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                }
            }
            
        case .deleteWaitingChat:
            FirestoreService.shared.deleteWaitingChat(chat: chat!) { (result) in
                switch result {
                case .success:
                    self.presenter?.presentData(response: .presentAlert(title: "Успешно", message: "Чат с \(self.chat!.friendUsername) был удален"))
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                }
            }
            
        }
    }
    
}
