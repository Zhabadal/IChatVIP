//
//  LoginVipModels.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum LoginVip {
    
    enum Model {
        struct Request {
            enum RequestType {
                case loginUser(email: String?, password: String?)
                case getUserData
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentAlert(title: String, message: String)
                case presentMainTabBar
                case presentSetupProfile
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayAlert(title: String, message: String)
                case displayMainTabBar
                case displaySetupProfile
            }
        }
    }
    
}
