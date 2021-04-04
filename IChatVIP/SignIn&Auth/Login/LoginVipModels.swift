//
//  LoginVipModels.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit
import GoogleSignIn

enum LoginVip {
    
    enum AlertType {
        case authorized
        case registered
        case other
    }
    
    enum Model {
        struct Request {
            enum RequestType {
                case loginUser(email: String?, password: String?)
                case googleLogin(user: GIDGoogleUser!, error: Error!)
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentAlert(title: String, message: String, type: AlertType)
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayAlert(title: String, message: String, type: AlertType)
            }
        }
    }
    
}
