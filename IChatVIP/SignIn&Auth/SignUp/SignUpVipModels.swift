//
//  SignUpVipModels.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 28.03.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum SignUpVip {
    
    enum Model {
        struct Request {
            enum RequestType {
                case registerUser(email: String?, password: String?, confirmPassword: String?)
            }
        }
        
        struct Response {
            enum ResponseType {
                case presentAlert(title: String, message: String)
            }
        }
        
        struct ViewModel {
            enum ViewModelData {
                case displayAlert(title: String, message: String)
            }
        }
    }
    
}
