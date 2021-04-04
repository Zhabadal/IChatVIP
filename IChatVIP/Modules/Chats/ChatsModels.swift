//
//  ChatsModels.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 04.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Chats {
    
    enum Model {
        struct Request {
            enum RequestType {
                case getUserInfo
                case setTitle
                case setMessagesObserve(messages: [MMessage])
                case sendMessage(text: String)
                case sendImage(_ image: UIImage)
            }
        }
        struct Response {
            enum ResponseType {
                case presentUserInfo(userId: String, userName: String)
                case presentTitle(_ title: String)
                case presentScrollToBottom
                case presentAlert(title: String, message: String)
                case presentMessages(messages: [MMessage], isLatestMessage: Bool)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayUserInfo(userId: String, userName: String)
                case displayTitle(_ title: String)
                case displayScrollToBottom
                case displayAlert(title: String, message: String)
                case displayMessages(messages: [MMessage], isLatestMessage: Bool)
            }
        }
    }
    
}
