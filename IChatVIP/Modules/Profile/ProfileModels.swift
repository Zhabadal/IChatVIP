//
//  ProfileModels.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum Profile {
    
    enum Model {
        struct Request {
            enum RequestType {
                case setUserInfo
                case sendMessage(text: String?)
            }
        }
        struct Response {
            enum ResponseType {
                case presentUserInfo(username: String, description: String, avatarStringUrl: String)
                case presentParent
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayUserInfo(username: String, description: String, avatarUrl: URL?)
                case displayParent
            }
        }
    }
    
}
