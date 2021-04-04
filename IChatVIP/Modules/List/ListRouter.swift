//
//  ListRouter.swift
//  IChatVIP
//
//  Created by Александр Бадмаев on 02.04.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.
//

import UIKit

protocol ListRoutingLogic {
    func showAlert(title: String?, message: String)
    func routeToChatRequest()
    func routeToChat()
}

protocol ListDataPassing {
    var dataStore: ListDataStore? { get }
}

class ListRouter: NSObject, ListRoutingLogic, ListDataPassing {    
    
    weak var viewController: ListViewController?
    var dataStore: ListDataStore?
    
    // MARK: Routing
    
    func showAlert(title: String?, message: String) {
        if let viewController = viewController {
            let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Ok", style: .default)
            alertVC.addAction(okAction)
            presentFrom(source: viewController, destination: alertVC)
        }
    }
    
    func routeToChatRequest() {
        let destinationVC = ChatRequestViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToChatRequest(source: dataStore!, destination: &destinationDS)
        presentFrom(source: viewController!, destination: destinationVC)
    }
    
    func routeToChat() {
        let destinationVC = ChatsViewController()
        var destinationDS = destinationVC.router!.dataStore!
        passDataToChat(source: dataStore!, destination: &destinationDS)
        navigateToChat(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    private func presentFrom(source: UIViewController, destination: UIViewController) {
        source.present(destination, animated: true)
    }
    
    private func navigateToChat(source: UIViewController, destination: UIViewController) {
        source.navigationController?.pushViewController(destination, animated: true)
    }
    
    // MARK: Passing data
    
    func passDataToChatRequest(source: ListDataStore, destination: inout ChatRequestDataStore) {
        destination.chat = source.chat
    }
    
    func passDataToChat(source: ListDataStore, destination: inout ChatsDataStore) {
        destination.user = source.currentUser
        destination.chat = source.chat
    }

}
