//
//  ChatRequestRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ChatRequestRoutingLogic {
    func routeToParent(chatAccepted: Bool)
}

protocol ChatRequestDataPassing {
    var dataStore: ChatRequestDataStore? { get }
}

class ChatRequestRouter: NSObject, ChatRequestRoutingLogic, ChatRequestDataPassing {
    
    weak var viewController: ChatRequestViewController?
    var dataStore: ChatRequestDataStore?
    
    // MARK: Routing
    
    func routeToParent(chatAccepted: Bool) {
        let mainTabBarVC = viewController?.presentingViewController as! MainTabBarViewController
        let navVC = mainTabBarVC.viewControllers?[1] as! UINavigationController
        let destinationVC = navVC.topViewController as! ListViewController
        navigateToParent(source: viewController!, destination: destinationVC, chatAccepted: chatAccepted)
    }

    // MARK: Navigation
    
    func navigateToParent(source: ChatRequestViewController, destination: ListViewController, chatAccepted: Bool) {
        source.dismiss(animated: true) {
            destination.interactor?.makeRequest(request: chatAccepted ? .changeChatToActive : .deleteWaitingChat)
        }
    }

    // MARK: Passing data
    
//    func passDataToSomewhere(source: ChatRequestDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }

}
