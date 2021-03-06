//
//  ChatRequestModels.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum ChatRequest {
    
    enum Model {
        struct Request {
            enum RequestType {
                case setChatInfo
            }
        }
        struct Response {
            enum ResponseType {
                case presentChatInfo(friendUsername: String, friendAvatarStringURL: String)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayChatInfo(friendUsername: String, friendAvatarURL: URL?)
            }
        }
    }
    
}
