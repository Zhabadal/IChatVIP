//
//  ChatsInteractor.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 04.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import FirebaseFirestore

protocol ChatsBusinessLogic {
    func makeRequest(request: Chats.Model.Request.RequestType)
}

protocol ChatsDataStore {
    var user: MUser! { get set }
    var chat: MChat! { get set }
}

class ChatsInteractor: ChatsBusinessLogic, ChatsDataStore {
    
    var presenter: ChatsPresentationLogic?
    var service: ChatsService?
    
    var user: MUser!
    var chat: MChat!
    
    private var messageListener: ListenerRegistration?
    
    func makeRequest(request: Chats.Model.Request.RequestType) {
        if service == nil {
            service = ChatsService()
        }
        
        switch request {
        case .getUserInfo:
            presenter?.presentData(response: .presentUserInfo(userId: user.id, userName: user.username))
            
        case .setTitle:
            presenter?.presentData(response: .presentTitle(chat.friendUsername))
            
        case .sendMessage(let text):
            let message = MMessage(user: user, content: text)
            FirestoreService.shared.sendMessage(chat: chat, message: message) { (result) in
                switch result {
                case .success():
                    self.presenter?.presentData(response: .presentScrollToBottom)
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                }
            }
            
        case .sendImage(let image):
            StorageService.shared.uploadImageMessage(photo: image, to: chat) { (result) in
                switch result {
                case .success(let url):
                    var message = MMessage(user: self.user, image: image)
                    message.downloadURL = url
                    
                    FirestoreService.shared.sendMessage(chat: self.chat, message: message) { (result) in
                        switch result {
                        case .success:
                            self.presenter?.presentData(response: .presentScrollToBottom)
                        case .failure(_):
                            self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: "Изображение не доставлено"))
                        }
                    }
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                }
            }
            
        case .setMessagesObserve(var messages):
            // Следим за каждым сообщением!
            messageListener = ListenerService.shared.messagesObserve(chat: chat, completion: { (result) in
                switch result {
                case .success(var message):
                    if let url = message.downloadURL {
                        StorageService.shared.downloadImage(url: url) { (result) in
                            switch result {
                            case .success(let image):
                                message.image = image
                                
                                guard !messages.contains(message) else { return }
                                messages.append(message)
                                messages.sort()

                                let isLatestMessage = messages.firstIndex(of: message) == (messages.count - 1)
                                self.presenter?.presentData(response: .presentMessages(messages: messages, isLatestMessage: isLatestMessage))
                                
                            case .failure(let error):
                                self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                            }
                        }
                    } else {
                        guard !messages.contains(message) else { return }
                        messages.append(message)
                        messages.sort()

                        let isLatestMessage = messages.firstIndex(of: message) == (messages.count - 1)
                        self.presenter?.presentData(response: .presentMessages(messages: messages, isLatestMessage: isLatestMessage))
                    }
                    
                case .failure(let error):
                    self.presenter?.presentData(response: .presentAlert(title: "Ошибка", message: error.localizedDescription))
                }
            })
            
        }
    }
        
}
