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
            }
        }
        struct Response {
            enum ResponseType {
                case presentTitle(_ title: String)
            }
        }
        struct ViewModel {
            enum ViewModelData {
                case displayTitle(_ title: String)
            }
        }
    }
    
}
