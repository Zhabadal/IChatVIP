//
//  ListModels.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum List {
    
    enum Model {
        struct Request {
            enum RequestType {
                case setTitle
                case setChatsObservers(waitingChats: [MChat], activeChats: [MChat])
                case chatSelected(chat: MChat)
                case changeChatToActive
                case deleteWaitingChat
            }
        }
        struct Response {
            enum ResponseType {
                case presentTitle(_ title: String)
                case presentChatRequest
                case presentWaitingChats(_ chats: [MChat])
                case presentActiveChats(_ chats: [MChat])
                case presentAlert(title: String, message: String)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayTitle(_ title: String)
                case displayChatRequest
                case displayWaitingChats(_ chats: [MChat])
                case displayActiveChats(_ chats: [MChat])
                case displayAlert(title: String, message: String)
            }
        }
    }
    
}
