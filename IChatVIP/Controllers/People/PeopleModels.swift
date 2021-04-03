//
//  PeopleModels.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum People {
    
    enum AlertType {
        case signOut
        case errorUsersListener
    }
    
    enum Model {
        struct Request {
            enum RequestType {
                case signOut
                case setTitle
                case setUsersListener(users: [MUser])
            }
        }
        struct Response {
            enum ResponseType {
                case presentAuth
                case presentTitle(_ title: String)
                case presentUsers(_ users: [MUser])
                case presentAlert(title: String, message: String, type: AlertType)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayAuth
                case displayTitle(_ title: String)
                case displayUsers(_ users: [MUser])
                case displayAlert(title: String, message: String, type: AlertType)
            }
        }
    }
    
}
