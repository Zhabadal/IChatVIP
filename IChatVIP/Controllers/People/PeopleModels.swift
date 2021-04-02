//
//  PeopleModels.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

enum People {
    
    enum Model {
        struct Request {
            enum RequestType {
                case signOut
            }
        }
        struct Response {
            enum ResponseType {
                case presentAuth
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayAuth
            }
        }
    }
    
}
